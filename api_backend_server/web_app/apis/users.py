import datetime
import uuid

from flask import request, jsonify, current_app
from werkzeug.security import generate_password_hash
import jwt

import database
from models import Users
from api_utils import admin_scope_required


def signup_user():
    data = request.get_json()

    hashed_password = generate_password_hash(data["password"], method="sha256")
    public_id = str(uuid.uuid4())

    new_user = Users(
        public_id=public_id,
        name=data["username"],
        password=hashed_password,
        admin=False,
    )
    database.db_session.add(new_user)
    database.db_session.commit()

    return jsonify({"message": "registered successfuly", "user_id": public_id})


def login_user(token_info):

    token = jwt.encode(
        {
            "public_id": token_info["public_id"],
            "exp": datetime.datetime.utcnow() + datetime.timedelta(minutes=30),
            "scope": token_info["sub"],
        },
        current_app.config["SECRET_KEY"],
    )
    return jsonify({"token": token.decode("UTF-8")})


@admin_scope_required
def get_all_users(token_info):

    users = Users.query.all()

    result = []

    for user in users:
        user_data = {}
        user_data["public_id"] = user.public_id
        user_data["name"] = user.name
        user_data["admin"] = user.admin

        result.append(user_data)

    return jsonify({"users": result})
