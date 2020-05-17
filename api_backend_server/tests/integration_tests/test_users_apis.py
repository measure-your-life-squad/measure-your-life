from collections import namedtuple
import string
import random

import pytest
import requests
from requests.auth import HTTPBasicAuth

import integration_utils


def get_random_string(string_length=5):
    letters = string.ascii_lowercase

    return "".join([random.choice(letters) for i in range(0, string_length)])


@pytest.fixture(scope="module")
def credentials():
    Credentials = namedtuple("Credentials", "username password email")
    credentials = Credentials(
        username=get_random_string(),
        password="test_username_password",
        email=f"{get_random_string()}@email.com",
    )

    return credentials


def test_user_signup(credentials):
    payload = {
        "username": credentials.username,
        "password": credentials.password,
        "email": credentials.email,
    }

    response = requests.post("http://localhost:80/api/users/register", json=payload)
    response_json = response.json()

    assert response_json["message"] == "registered successfuly"
    assert integration_utils.is_valid_uuid(response_json["user_id"])


def test_user_login(credentials):
    response = requests.post(
        "http://localhost:80/api/users/login",
        auth=HTTPBasicAuth(credentials.username, credentials.password),
    )

    response_json = response.json()

    assert integration_utils.is_valid_jwt(response_json["token"])
