import datetime
import uuid

from flask import request, jsonify, current_app
from werkzeug.security import generate_password_hash
import jwt

from models import Users
from api_utils import admin_scope_required
from mongoengine.errors import NotUniqueError


def signup_user():
    data = request.get_json()

    hashed_password = generate_password_hash(data["password"], method="sha256")
    public_id = str(uuid.uuid4())

    try:
        Users(
            public_id=public_id,
            name=data["username"],
            password=hashed_password,
            admin=False,
        ).save()
    except NotUniqueError:
        return jsonify({"message": "unsuccessful, username already in use"}), 409

    return jsonify({"message": "registered successfuly", "user_id": public_id}), 200


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

    users = Users.objects.only("public_id", "name", "admin",).exclude("id")

    return jsonify({"users": users}), 200
