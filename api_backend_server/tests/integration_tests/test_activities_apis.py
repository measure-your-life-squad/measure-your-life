from collections import namedtuple

import pytest
import requests
from requests.auth import HTTPBasicAuth

import integration_utils


def _get_credentials():
    Credentials = namedtuple("Credentials", "username password email")
    credentials = Credentials(
        username="dummyuser",
        password="minor security threat",
        email="dummyuser@myl.com",
    )

    return credentials


@pytest.fixture(scope="module")
def activity():
    Activity = namedtuple("Activity", "name category_id activity_start activity_end")
    activity = Activity(
        name="dummy_activity",
        category_id="1",
        activity_start="2020-04-30 09:34:35.414677+02:00",
        activity_end="2020-04-30 11:34:35.414677+02:00"
    )
    return activity


@pytest.fixture
def valid_jwt_token(scope="module"):
    credentials = _get_credentials()

    response = requests.post(
        "http://localhost:80/api/users/login",
        auth=HTTPBasicAuth(credentials.username, credentials.password),
    )

    response_json = response.json()

    return response_json["token"]


def test_create_activity_should_succeed(activity, valid_jwt_token):

    auth_token = valid_jwt_token
    header = {'Authorization': 'Bearer ' + auth_token}

    payload = {
        "name": activity.name,
        "category_id": activity.category_id,
        "activity_start": activity.activity_start,
        "activity_end": activity.activity_end
    }

    response = requests.post(
        "http://localhost:80/api/activities",
        headers=header,
        json=payload,
    )
    response_json = response.json()
    print(response_json)

    assert integration_utils.is_valid_uuid(response_json["activity_id"])
