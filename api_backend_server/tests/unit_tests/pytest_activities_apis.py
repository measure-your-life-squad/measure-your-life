from api_backend_server.web_app.apis.activities import _convert_unix_to_iso8610, _parse_to_utc_iso8610
from api_backend_server.web_app.apis.activities import create_activity, get_user_activities
import pytest
import datetime
import mock as mock
from mock import MagicMock


def test__parse_to_utc_iso8610_should_succeed():
    # given
    string_timestamp = '2020-04-30 09:34:35.414677'

    # when
    result = _parse_to_utc_iso8610(string_timestamp)

    # then
    assert result == '2020-04-30 07:34:35.414677+00:00'


def test__parse_to_utc_iso8610_should_throw_exception():
    # given

    # when
    with pytest.raises(Exception):
        _parse_to_utc_iso8610(None)

    # then


def test__convert_unix_to_iso8610_should_succeed():
    # given
    unix_timestamp  = datetime.datetime.fromtimestamp(1588248502)

    # when
    result = _convert_unix_to_iso8610(unix_timestamp)

    # then
    assert result == '2020-04-30T14:08:22+00:00'


def test__convert_unix_to_iso8610_should_throw_exception():
    # given
    unix_timestamp  = 1588248502

    # when
    with pytest.raises(Exception):
        _convert_unix_to_iso8610(unix_timestamp)
    
    # then

# NOT FINISHED TEST METHOD
# #@mock.patch('api_backend_server.web_app.apis.activities.create_activity', MagicMock(return_value = ))
# # def test_create_activity_should_succeed():
# #     # given
# #     data = {
# #         "activity_start": '2020-04-30 09:34:35.414677',
# #         "activity_end": '2020-04-30 11:34:35.414677',
# #         "name": "reading book",
# #         "public_id": '21',
# #         "category_id": 'entertainment'
# #     }

# #     # when
    
# #     # then
# #     assert result == "new activity record created"


# NOT FINISHED TEST METHOD
# #def test_get_user_activity_should_succeed():
