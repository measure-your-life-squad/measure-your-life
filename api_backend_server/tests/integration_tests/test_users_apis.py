from collections import namedtuple
from uuid import UUID
import string
import random
import re

import pytest
import requests
from requests.auth import HTTPBasicAuth


def is_valid_uuid(id_to_test):
    try:
        UUID(str(id_to_test))
        return True
    except ValueError:
        return False


def is_valid_jwt(token_to_test):

    match = re.search(r"^[A-Za-z0-9-_=]+\.[A-Za-z0-9-_=]+\.[A-Za-z0-9-_.+/=]*$", token_to_test)

    return bool(match)


def get_random_string(string_length=5):
    letters = string.ascii_lowercase

    return "".join([random.choice(letters) for i in range(0, string_length)])


@pytest.fixture(scope="module")
def credentials():
    Credentials = namedtuple("Credentials", "username password")
    credentials = Credentials(
        username=get_random_string(), password="test_username_password"
    )

    return credentials


def test_user_signup(credentials):
    payload = {
        "username": credentials.username,
        "password": credentials.password,
    }

    response = requests.post("http://localhost:5000/api/users/register", json=payload)
    response_json = response.json()

    assert response_json["message"] == "registered successfuly"
    assert is_valid_uuid(response_json["user_id"])


def test_user_login(credentials):
    response = requests.post(
        "http://localhost:5000/api/users/login",
        auth=HTTPBasicAuth(credentials.username, credentials.password),
    )

    response_json = response.json()

    assert is_valid_jwt(response_json["token"])
