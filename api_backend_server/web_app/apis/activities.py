import uuid
import datetime
from datetime import timezone as tmzone

from dateutil import parser as dp
from dateutil import tz
from flask import request, jsonify

from models import Activities
from apis import categories


def create_activity(token_info):

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


def get_user_activities(token_info):

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


def _convert_unix_to_iso8610(unix_timestamp: datetime):

    iso_timestamp = unix_timestamp.replace(tzinfo=tmzone.utc).isoformat()

    return iso_timestamp


def _parse_to_utc_iso8610(string_timestamp: str):

    return dp.isoparse(string_timestamp).astimezone(tz.UTC)
