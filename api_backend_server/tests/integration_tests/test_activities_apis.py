import pytest
import requests
from collections import namedtuple

@pytest.fixture(scope="module")
def credentials():
    Credentials = namedtuple("Credentials", "name category_id activity_start activity_end")
    credentials = Credentials(
        name="dummy_activity",
        category_id=1,
        activity_start="2020-04-30 09:34:35.414677",
        activity_end="2020-04-30 11:34:35.414677"
    )
    return credentials


def test_create_activity_should_succeed():

    payload = {
        "name": credentials.name,
        "category_id":credentials.category_id,
        "activity_start": credentials.activity_start,
        "activity_end": credentials.activity_end
    }

    response = requests.post("http://localhost:5000/api/activity/create_activity", json=payload)
    response_json = response.json()

    assert response_json["message"] == "new activity created"

