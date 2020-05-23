from typing import Tuple
from math import ceil

from flask import Response, jsonify
from mongoengine import Document

from models import Activities, Categories
from api_utils import auth_utils


CATEGORIES = {
    "WORK": "1",
    "DUTIES": "2",
    "LEISURE": "3",
}

MINS_IN_HOUR = 1440


def _calculate_category_duration(user_id: str, category_id: str) -> float:
    category = Categories.get_specific_category(category_id=category_id)

    activities = Activities.objects(user_id=user_id, category=category).exclude("id")

    sum_duration = sum([activity.duration for activity in activities])

    return sum_duration


def _calculate_time_window(activities: Document) -> float:

    min_start = min([activity.activity_start for activity in activities])
    max_end = max([activity.activity_end for activity in activities])

    time_window = (max_end - min_start).total_seconds() / 60

    return time_window


def _calculate_daily_average(sum_duration: float, time_window: float) -> int:
    days_rounded_up = ceil(time_window / MINS_IN_HOUR)

    daily_average = sum_duration / days_rounded_up

    return int(daily_average)


def _calculate_category_share(sum_duration: float, time_window: float):

    share = sum_duration / time_window

    return share


def _build_shared_json(time_window: float, user_id: str) -> dict:
    result = {}
    for cat, cat_id in CATEGORIES.items():

        duration = _calculate_category_duration(user_id, cat_id)

        share = _calculate_category_share(duration, time_window)

        result.update({cat: share})

    return result


def _build_averages_json(time_window: float, user_id: str) -> dict:
    result = {}
    for cat, cat_id in CATEGORIES.items():

        duration = _calculate_category_duration(user_id, cat_id)

        average = _calculate_daily_average(duration, time_window)

        result.update({f"{cat}_AVG": average})

    return result


@auth_utils.confirmed_user_required
def get_rolling_meter(
    token_info: dict, include_unassigned: bool = True
) -> Tuple[Response, int]:
    activities = Activities.objects(user_id=token_info["public_id"]).exclude("id")

    if include_unassigned:
        time_window = _calculate_time_window(activities)
    else:
        time_window = sum([activity.duration for activity in activities])

    share_response = _build_shared_json(time_window, token_info["public_id"])

    average_response = _build_averages_json(time_window, token_info["public_id"])

    share_response.update(average_response)

    return jsonify(share_response)
