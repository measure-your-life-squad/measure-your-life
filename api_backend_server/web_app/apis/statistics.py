from typing import Tuple

from flask import Response, jsonify
from mongoengine import Document

from models import Activities, Categories
from api_utils import auth_utils


CATEGORIES = {
    "WORK": "1",
    "DUTIES": "2",
    "LEISURE": "3",
}


def _calculate_category_duration(user_id: str, category_id: str) -> float:
    category = Categories.get_specific_category(category_id=category_id)

    activities = Activities.objects(user_id=user_id, category=category).exclude("id")

    sum_duration = sum([activity.duration for activity in activities])

    return sum_duration


def _calculate_category_share(sum_duration: float, time_window: float):

    share = sum_duration / time_window

    return share


def _calculate_time_window(activities: Document) -> float:

    min_start = min([activity.activity_start for activity in activities])
    max_end = max([activity.activity_end for activity in activities])

    time_window = (max_end - min_start).total_seconds() / 60

    return time_window


@auth_utils.confirmed_user_required
def get_rolling_meter(
    token_info: dict, include_unassigned: bool = True
) -> Tuple[Response, int]:
    activities = Activities.objects(user_id=token_info["public_id"]).exclude("id")

    if include_unassigned:
        time_window = _calculate_time_window(activities)
    else:
        time_window = sum([activity.duration for activity in activities])

    result = {}
    for cat, cat_id in CATEGORIES.items():

        duration = _calculate_category_duration(token_info["public_id"], cat_id)

        share = _calculate_category_share(duration, time_window)

        result.update({cat: share})

    return jsonify(result)
