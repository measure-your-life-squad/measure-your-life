from flask import jsonify, Response


def hello() -> Response:
    return jsonify(message="Hello from Python backend server")
