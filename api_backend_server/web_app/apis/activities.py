import uuid
import datetime
from typing import Tuple

from dateutil import parser as dp
from dateutil import tz
from flask import request, jsonify, Response

from models import Activities, Categories
from api_utils import auth_utils


@auth_utils.confirmed_user_required
def create_activity(token_info: dict) -> Tuple[Response, int]:

    data = request.get_json()

    start = _parse_to_utc_iso8610(data["activity_start"])
    end = _parse_to_utc_iso8610(data["activity_end"])
    activity_id = str(uuid.uuid4())

    category = Categories.get_specific_category(data["category_id"])

    duration = _calculate_duration_in_mins(start, end)

    Activities(
        activity_id=activity_id,
        name=data["name"],
        user_id=token_info["public_id"],
        activity_start=start,
        activity_end=end,
        category=category,
        duration=duration,
    ).save()

    return jsonify({"activity_id": activity_id}), 200


@auth_utils.confirmed_user_required
def get_user_activities(token_info: dict) -> Tuple[Response, int]:

    activities = Activities.objects(user_id=token_info["public_id"]).exclude("id")

    parsed_activities = [
        {
            "activity_id": activity.activity_id,
            "user_id": activity.user_id,
            "name": activity.name,
            "category": activity.category.public_id,
            "activity_start": _convert_unix_to_iso8610(activity.activity_start),
            "activity_end": _convert_unix_to_iso8610(activity.activity_end),
        }
        for activity in activities
    ]

    return jsonify({"activities": parsed_activities}), 200


@auth_utils.confirmed_user_required
def delete_user_activity(token_info: dict, activity_id: str) -> Tuple[Response, int]:

    Activities.delete_specific_activity(activity_id)

    return jsonify({"message": f"Activity {activity_id} successfully deleted."}), 200


@auth_utils.confirmed_user_required
def edit_user_activity(token_info: dict, activity_id: str) -> Tuple[Response, int]:

    data = request.get_json()

    category = Categories.get_specific_category(data.pop("category_id"))

    start = _parse_to_utc_iso8610(data["activity_start"])
    end = _parse_to_utc_iso8610(data["activity_end"])

    data.update(category=category)

    data.update(
        duration=_calculate_duration_in_mins(
            start,
            end
        )
    )

    data["activity_start"] = start
    data["activity_end"] = end

    updated_activity = Activities.edit_specific_activity(activity_id, **data)

    print(updated_activity)

    return jsonify({"message": f"Activity {activity_id} successfully updated."}), 200


def _convert_unix_to_iso8610(unix_timestamp: datetime) -> str:

    iso_timestamp = unix_timestamp.astimezone(tz.UTC).isoformat()

    return iso_timestamp


def _parse_to_utc_iso8610(string_timestamp: str) -> datetime:

    return dp.isoparse(string_timestamp).astimezone(tz.UTC)


def _calculate_duration_in_mins(start: datetime, end: datetime) -> float:

    duration = (end - start).total_seconds() / 60

    return duration
