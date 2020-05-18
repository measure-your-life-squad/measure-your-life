from functools import wraps
from typing import Callable
import six

from flask import jsonify, current_app
from werkzeug.security import check_password_hash
from werkzeug.exceptions import Unauthorized
import jwt
from jwt.exceptions import DecodeError
from itsdangerous import URLSafeTimedSerializer

from models import Users


def get_url_serializer_and_salt():
    serializer = URLSafeTimedSerializer(current_app.config["SECRET_KEY"])
    salt = current_app.config["SECURITY_PASSWORD_SALT"]

    return dict(serializer=serializer, salt=salt)


def generate_confirmation_token(email, serializer, salt):
    return serializer.dumps(email, salt=salt)


def confirm_token(token, serializer, salt, expiration=86400):
    try:
        email = serializer.loads(token, salt=salt, max_age=expiration)
    except Exception:
        # TODO: introduce auth logging
        return False
    return email


def basic_auth(username: str, password: str, required_scopes: str = None) -> dict:

    info = None

    # TODO: refactor to use Users static method to check if user exists and get user
    # document (violates DRY)

    try:
        (user,) = Users.objects(username=username)
    except ValueError as e:
        if (
            len(e.args) > 0
            and e.args[0] == "not enough values to unpack (expected 1, got 0)"
        ):
            raise ValueError(
                f"User with username={username} not found in the Database"
            ) from e
        else:
            raise ValueError(
                f"More than one user with username={username} found in the Database"
            ) from e

    if check_password_hash(user.password, password):
        if user.admin:
            info = {"sub": "admin", "public_id": str(user.public_id)}
        else:
            info = {"sub": "user", "public_id": str(user.public_id)}

        info.update(email_confirmed=user.email_confirmed)

    return info


def decode_token(token: str) -> dict:
    try:
        return jwt.decode(token, current_app.config["SECRET_KEY"])
    except DecodeError as e:
        six.raise_from(Unauthorized, e)


def admin_scope_required(f: Callable) -> Callable:
    @wraps(f)
    def wrapper(*args, **kwargs):

        if kwargs["token_info"]["scope"] == "admin":
            return f(*args, **kwargs)
        else:
            return jsonify(
                {
                    "detail": "The server could not verify that you are authorized to access the URL requested. You either supplied the wrong credentials (e.g. a bad password), or your browser doesn't understand how to supply the credentials required.",  # NOQA
                    "status": 401,
                    "title": "Unauthorized",
                    "type": "about:blank",
                }
            )

    return wrapper


def confirmed_user_required(f: Callable) -> Callable:
    @wraps(f)
    def wrapper(*args, **kwargs):

        (user,) = Users.objects(public_id=kwargs["token_info"]["public_id"])

        if user.email_confirmed:
            return f(*args, **kwargs)
        else:
            return jsonify(
                {
                    "detail": "This operation is allowed only for confirmed user accounts. Please confirm your email address.",  # NOQA
                    "status": 401,
                    "title": "Unauthorized",
                    "type": "about:blank",
                }
            )

    return wrapper
