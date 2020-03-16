from dateutil import parser as dp
from dateutil import tz
from flask import request, jsonify

import database
from models import Activities


def create_activity(token_info):

    data = request.get_json()

    start = dp.isoparse(data["activity_start"]).astimezone(tz.UTC)
    end = dp.isoparse(data["activity_end"]).astimezone(tz.UTC)

    new_activities = Activities(
        name=data["name"],
        user_id=token_info["public_id"],
        activity_start=start,
        activity_end=end,
    )
    database.db_session.add(new_activities)
    database.db_session.commit()

    return jsonify({"message": "new activity record created"})


def get_user_activities(token_info):

    activities = Activities.query.filter_by(user_id=token_info["public_id"]).all()

    output = []
    for activity in activities:

        activity_data = {}
        activity_data["name"] = activity.name
        activity_data["activity_start"] = activity.activity_start
        activity_data["activity_end"] = activity.activity_end
        output.append(activity_data)

    return jsonify({"activities": output})
