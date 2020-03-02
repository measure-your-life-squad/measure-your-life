import datetime
from functools import wraps
import os
from pathlib import Path


from flask import Flask, request, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
import uuid
import jwt


app = Flask(__name__)

app.config["SECRET_KEY"] = os.getenv("SECRET_KEY", "very_very_secret_secret")
app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv(
                                                   "SQLALCHEMY_DATABASE_URI",
                                                   "".join([
                                                            "sqlite:////",
                                                            str(Path.cwd().joinpath("local.db"))
                                                            ])
                                                  )
app.config["SQLALCHAMY_TRACK_MODIFICATIONS"] = True


db = SQLAlchemy(app)


class Users(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    public_id = db.Column(db.Integer)
    name = db.Column(db.String(50))
    password = db.Column(db.String(50))
    admin = db.Column(db.Boolean)


class Activities(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer)
    name = db.Column(db.String(50), unique=False, nullable=False)


def token_required(f):
    @wraps(f)
    def wrapper(*args, **kwargs):

        token = None

        if "x-access-tokens" in request.headers:
            token = request.headers["x-access-tokens"]

        if not token:
            return jsonify({"message": "a valid token is missing"})

        try:
            data = jwt.decode(token, app.config["SECRET_KEY"])
        except jwt.exceptions.DecodeError:
            return jsonify({"message": "token is invalid"})
        else:
            current_user = Users.query.filter_by(public_id=data['public_id']).first()

        return f(current_user, *args, **kwargs)

    return wrapper


@app.route("/", methods=["GET"])
def index():
    return jsonify(message="Hello from Python backend server")


@app.route("/api/users/register", methods=["POST"])
def signup_user():
    data = request.get_json()

    hashed_password = generate_password_hash(data["password"], method="sha256")
    public_id = str(uuid.uuid4())

    new_user = Users(public_id=public_id, name=data["name"], password=hashed_password, admin=False)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "registered successfuly",
                    "user_id": public_id})


@app.route("/api/users/login", methods=["POST"])
def login_user():

    auth = request.authorization

    if not auth or not auth.username or not auth.password:
        return make_response("could not verify", 401, {"WWW.Authentication": "Basic Reals: 'login required'"})

    user = Users.query.filter_by(name=auth.username).first()

    if check_password_hash(user.password, auth.password):
        token = jwt.encode(
                            {
                              "public_id": user.public_id,
                              "exp": datetime.datetime.utcnow() + datetime.timedelta(minutes=30)
                            },
                            app.config["SECRET_KEY"]
                          )
        return jsonify({"token": token.decode("UTF-8")})

    return make_response("could not verify", 401, {"WWW.Authentication": "Basic realm: 'login required'"})


@app.route("/api/users", methods=["GET"])
@token_required
def get_all_users(current_user):

    users = Users.query.all()

    result = []

    for user in users:
        user_data = {}
        user_data["public_id"] = user.public_id
        user_data["name"] = user.name
        user_data["password"] = user.password
        user_data["admin"] = user.admin

        result.append(user_data)

    return jsonify({"users": result})


@app.route("/api/activities", methods=["POST"])
@token_required
def create_activity(current_user):

    data = request.get_json()

    new_activities = Activities(name=data["name"], user_id=current_user.id)
    db.session.add(new_activities)
    db.session.commit()

    return jsonify({"message": "new activity created"})


@app.route("/api/activities", methods=["GET"])
@token_required
def get_user_activities(current_user):

    activities = Activities.query.filter_by(user_id=current_user.id).all()

    output = []
    for activity in activities:

        activity_data = {}
        activity_data["name"] = activity.name
        output.append(activity_data)

    return jsonify({"list_of_activities": output})


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
