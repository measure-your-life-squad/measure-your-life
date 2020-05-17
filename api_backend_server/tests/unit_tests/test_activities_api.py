import datetime
from pytz import timezone

import pytest

from api_backend_server.web_app.apis.activities import (
    _parse_to_utc_iso8610,
    _convert_unix_to_iso8610,
    _calculate_duration_in_mins,
)


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
