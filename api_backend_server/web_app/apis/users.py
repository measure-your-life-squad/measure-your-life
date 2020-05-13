import datetime
import uuid

import jwt
from flask import request, jsonify, current_app
from werkzeug.security import generate_password_hash
from mongoengine.errors import NotUniqueError, ValidationError

from models import Users
from api_utils.auth_utils import admin_scope_required
from api_utils.email_utils import send_confirmation_email
from api_utils.auth_utils import (
    get_url_serializer_and_salt,
    confirm_token,
)


def save_user(**kwargs):
    try:
        Users(**kwargs).save()
    except NotUniqueError:
        payload = {"message": "username or email address already in use"}
        http_code = 409
    except ValidationError as e:
        if e.message and "Invalid email address" in e.message:
            payload = {"message": f"invalid email address: {kwargs['email']}"}
            http_code = 422
        else:
            raise e
    else:
        payload = {"message": "registered successfuly", "user_id": kwargs["public_id"]}
        http_code = 200

    return dict(payload=payload, http_code=http_code)


def confirm_email(token):
    safe_url_token_tools = get_url_serializer_and_salt()
    try:
        email = confirm_token(token, **safe_url_token_tools)
        (user,) = Users.objects(email=email)
    except Exception:
        # TODO: introduce auth logging
        return jsonify({"message": "The confirmation link is invalid or has expired."})
    if user.email_confirmed:
        return jsonify({"message": "Account already confirmed. Please login."})
    else:
        user.update(set__email_confirmed=True)
    # TODO: redirect to some default website

    return jsonify({"message": "Successful email verification operation"}), 200


def resend_confirmation_email():
    data = request.get_json()

    if not Users.validate_if_existing_user(email=data["email"]):
        return jsonify(
            {
                "message": "This email is not linked to any of existing user accounts."
            }
        )

    send_email_response = send_confirmation_email(data["email"])

    if send_email_response in range(200, 300):
        return jsonify({"message": "Confirmation email resent successfully."}), 200
    else:
        return jsonify({"message": "Oops, something went wrong :("}), 500


def signup_user():
    data = request.get_json()

    data["password"] = generate_password_hash(data["password"], method="sha256")
    data["public_id"] = str(uuid.uuid4())
    data["admin"] = False
    data["email_confirmed"] = False

    # TODO: saving and deleting the user in case of email confirmation failures are
    # atomic operations - they should be refactored to a single transaction
    # (pymongo use may be necessary, mongoengine does not support transactions)

    saving_user_outcome = save_user(**data)

    if saving_user_outcome["http_code"] != 200:
        return jsonify(saving_user_outcome["payload"]), saving_user_outcome["http_code"]

    send_email_response = send_confirmation_email(data["email"])

    if send_email_response in range(200, 300):
        return jsonify(saving_user_outcome["payload"]), saving_user_outcome["http_code"]
    else:
        Users.delete_user(saving_user_outcome["payload"]["user_id"])
        return jsonify({"message": "Oops, something went wrong :("}), 500


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

    users = Users.objects.only(
        "public_id", "username", "admin", "email", "email_confirmed"
    ).exclude("id")

    return jsonify({"users": users}), 200
