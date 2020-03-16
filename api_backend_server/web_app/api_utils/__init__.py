from functools import wraps
import six

from flask import jsonify, current_app
from werkzeug.security import check_password_hash
from werkzeug.exceptions import Unauthorized
import jwt
from jwt.exceptions import DecodeError

from models import Users


def basic_auth(username, password, required_scopes=None):

    info = None

    current_app.logger.info(username)
    user = Users.query.filter(Users.name == username).first()

    if user:
        if check_password_hash(user.password, password):
            if user.admin:
                info = {"sub": "admin", "public_id": user.public_id}
            else:
                info = {"sub": "user", "public_id": user.public_id}

    return info


def decode_token(token):
    try:
        return jwt.decode(token, current_app.config["SECRET_KEY"])
    except DecodeError as e:
        six.raise_from(Unauthorized, e)


def admin_scope_required(f):
    @wraps(f)
    def wrapper(*args, **kwargs):

        current_app.logger.info([*kwargs])
        current_app.logger.info(kwargs["token_info"])
        if (
            kwargs["token_info"]["scope"] == "admin"
        ):
            return f(*args, **kwargs)
        else:
            return jsonify(
                {
                    "detail": "The server could not verify that you are authorized to access the URL requested. You either supplied the wrong credentials (e.g. a bad password), or your browser doesn't understand how to supply the credentials required.",
                    "status": 401,
                    "title": "Unauthorized",
                    "type": "about:blank",
                }
            )
    return wrapper