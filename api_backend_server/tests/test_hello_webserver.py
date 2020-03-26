import requests


def test_get_hello_message():
    response = requests.get("http://localhost:5000")

    assert response.json()["message"] == "Hello from Python backend server"
