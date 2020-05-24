from api_backend_server.web_app.apis.activities import (
    _parse_to_utc_iso8610,
    _convert_unix_to_iso8610,
    _calculate_duration_in_mins,
    _validate_time_overlapping,
)

from api_backend_server.web_app.models import Activities
import datetime
from pytz import timezone

import pytest
from mongoengine import connect


@pytest.fixture(scope='function')
def mongo(request):
    db = connect('mongoenginetest', host='mongomock://localhost')
    yield db
    db.drop_database('mongoenginetest')
    db.close()


def test__parse_to_utc_iso8610_should_succeed():
    # given
    received_timestamp = "2020-05-15T18:30:25,860283993+02:00"

    utc = timezone("UTC")
    in_utc_time = utc.localize(datetime.datetime(2020, 5, 15, 16, 30, 25, 860283))

    # when
    result = _parse_to_utc_iso8610(received_timestamp)

    # then
    assert result == in_utc_time


def test__parse_to_utc_iso8610_should_throw_exception():
    # given
    invalid_timestamp = "15-05-2015 18:30:25,860283993"

    # then
    with pytest.raises(Exception):
        _parse_to_utc_iso8610(invalid_timestamp)


def test__convert_unix_to_iso8610():
    # given
    utc = timezone("UTC")
    unix_timestamp = utc.localize(datetime.datetime.utcfromtimestamp(1588248502))

    # when
    result = _convert_unix_to_iso8610(unix_timestamp)

    # then
    assert result == "2020-04-30T12:08:22+00:00"


def test__calculate_duration_in_mins():
    # given
    start = datetime.datetime(2020, 5, 15, 16, 30, 25)
    end = datetime.datetime(2020, 5, 15, 20, 45, 25)

    # when
    duration = _calculate_duration_in_mins(start, end)

    # then
    assert duration == float(255)


simple_activity_data = {'activity_id': "6fdfa589-412c-489f-92fa-b472ee9fae7c",
                        'name': "activity_sample",
                        'user_id': "4f175f70-d192-42a4-bd74-6f5b5baf7963",
                        'activity_start': _parse_to_utc_iso8610(
                            "2020-05-15T14:30:25+00:00"),
                        'activity_end': _parse_to_utc_iso8610(
                            "2020-05-15T16:30:25+00:00"),
                        'category_id': "1",
                        'duration': 120.0,
                        }


def test__validate_time_overlapping_overlap_not_occurs(mongo):

    new_activity_start = "2020-05-15T05:30:25+00:00"
    new_activity_end = "2020-05-15T07:30:25+00:00"

    Activities(activity_id=simple_activity_data['activity_id'],
               name=simple_activity_data['name'],
               user_id=simple_activity_data['user_id'],
               activity_start=simple_activity_data['activity_start'],
               activity_end=simple_activity_data['activity_end'],
               category=simple_activity_data['category_id'],
               duration=simple_activity_data['duration'],
               ).save()

    token_info_for_test = {'public_id': '4f175f70-d192-42a4-bd74-6f5b5baf7963'}
    result = _validate_time_overlapping(_parse_to_utc_iso8610(new_activity_start),
                                        _parse_to_utc_iso8610(new_activity_end),
                                        token_info_for_test)
    assert result is False


def test__validate_time_overlapping_overlap_occurs(mongo):

    new_activity_start = "2020-05-15T15:30:25+00:00"
    new_activity_end = "2020-05-15T19:30:25+00:00"

    Activities(activity_id=simple_activity_data['activity_id'],
               name=simple_activity_data['name'],
               user_id=simple_activity_data['user_id'],
               activity_start=simple_activity_data['activity_start'],
               activity_end=simple_activity_data['activity_end'],
               category=simple_activity_data['category_id'],
               duration=simple_activity_data['duration'],
               ).save()

    token_info_for_test = {'public_id': '4f175f70-d192-42a4-bd74-6f5b5baf7963'}
    result = _validate_time_overlapping(_parse_to_utc_iso8610(new_activity_start),
                                        _parse_to_utc_iso8610(new_activity_end),
                                        token_info_for_test)
    assert result is True


def test_delete_specific_activity(mongo):

    Activities(activity_id=simple_activity_data['activity_id'],
               name=simple_activity_data['name'],
               user_id=simple_activity_data['user_id'],
               activity_start=simple_activity_data['activity_start'],
               activity_end=simple_activity_data['activity_end'],
               category=simple_activity_data['category_id'],
               duration=simple_activity_data['duration'],
               ).save()

    result = Activities.delete_specific_activity("6fdfa589-412c-489f-92fa-b472ee9fae7c")

    assert result is True
