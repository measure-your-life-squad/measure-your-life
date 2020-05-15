import uuid
import datetime
from typing import Tuple

from dateutil import parser as dp
from dateutil import tz
from flask import request, jsonify, Response

from models import Activities
from apis import categories
from api_utils import auth_utils


@auth_utils.confirmed_user_required
def create_activity(token_info: dict) -> Tuple[Response, int]:

    data = request.get_json()

    start = _parse_to_utc_iso8610(data["activity_start"])
    end = _parse_to_utc_iso8610(data["activity_end"])

    category = categories._get_specific_category(data["category_id"])

    Activities(
        activity_id=str(uuid.uuid4()),
        name=data["name"],
        user_id=token_info["public_id"],
        activity_start=start,
        activity_end=end,
        category=category,
    ).save()

    return jsonify({"message": "new activity record created"}), 200


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


def _convert_unix_to_iso8610(unix_timestamp: datetime) -> str:

    iso_timestamp = unix_timestamp.astimezone(tz.UTC).isoformat()

    return iso_timestamp


def _parse_to_utc_iso8610(string_timestamp: str) -> datetime:

    return dp.isoparse(string_timestamp).astimezone(tz.UTC)
