from random import randint


from flask import Flask
from flask import request
from flask import jsonify


app = Flask(__name__)


@app.route("/", methods=["GET"])
def index():
    return jsonify(message="Hello from Python backend server")


@app.route("/login", methods=["POST"])
def login():
    username = request.args.get("username")
    user_id = randint(0, 10)
    return jsonify(username=username,
                   userid=user_id)


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
