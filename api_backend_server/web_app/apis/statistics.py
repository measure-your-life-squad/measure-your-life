from typing import Tuple, Union
from math import ceil

from flask import Response, jsonify
from mongoengine import Document, QuerySet

from models import Activities, Categories
from api_utils import auth_utils
from apis.activities import _parse_to_utc_iso8610


CATEGORIES = {
    "WORK": "1",
    "DUTIES": "2",
    "LEISURE": "3",
}

NO_DATA_RESPONSE = {
    "WORK": 0.0,
    "WORK_AVG": 0,
    "DUTIES": 0.0,
    "DUTIES_AVG": 0,
    "LEISURE": 0.0,
    "LEISURE_AVG": 0,
}

MINS_IN_HOUR = 1440


def _calculate_category_duration(activities: QuerySet, category_id: str) -> float:
    category = Categories.get_specific_category(category_id=category_id)

    activities = [
        activity
        for activity in activities
        if activity.category == category
    ]

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


def _build_shared_json(time_window: float, activities: QuerySet) -> dict:
    result = {}
    for cat, cat_id in CATEGORIES.items():

        duration = _calculate_category_duration(activities, cat_id)

        share = _calculate_category_share(duration, time_window)

        result.update({cat: share})

    return result


def _build_averages_json(time_window: float, activities: QuerySet) -> dict:
    result = {}
    for cat, cat_id in CATEGORIES.items():

        duration = _calculate_category_duration(activities, cat_id)

        average = _calculate_daily_average(duration, time_window)

        result.update({f"{cat}_AVG": average})

    return result


@auth_utils.confirmed_user_required
def get_rolling_meter(
    token_info: dict,
    include_unassigned: bool = True,
    start_range: Union[str, None] = None,
    end_range: Union[str, None] = None,
) -> Tuple[Response, int]:
    if start_range and end_range:
        start_parsed = _parse_to_utc_iso8610(start_range).replace(tzinfo=None)
        end_parsed = _parse_to_utc_iso8610(end_range).replace(tzinfo=None)
        activities = Activities.objects(user_id=token_info["public_id"]).exclude("id")
        activities = [
            activity
            for activity in activities
            if (activity.activity_start >= start_parsed)
            and (activity.activity_end <= end_parsed)
        ]
    else:
        activities = Activities.objects(user_id=token_info["public_id"]).exclude("id")

    if include_unassigned:
        time_window = _calculate_time_window(activities)
    else:
        time_window = sum([activity.duration for activity in activities])

    if time_window == 0:
        return jsonify(
                NO_DATA_RESPONSE
            )

    share_response = _build_shared_json(time_window, activities)

    average_response = _build_averages_json(time_window, activities)

    share_response.update(average_response)

    return jsonify(share_response)


@auth_utils.confirmed_user_required
def get_oldest_date(token_info: dict) -> Tuple[Response, int]:
    oldest_activity = (
        Activities.objects(user_id=token_info["public_id"])
        .aggregate(
            [{"$group": {"_id": 0, "oldest_date": {"$min": "$activity_start"}, }}]
        )
        .next()
    )

    oldest_activity.pop("_id", None)

    return jsonify(oldest_activity)
