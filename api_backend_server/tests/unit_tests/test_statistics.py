from api_backend_server.web_app.apis.activities import _parse_to_utc_iso8610
from api_backend_server.web_app.apis.statistics import (
    _calculate_daily_average,
    _calculate_category_share
)


simple_activity_data = {'activity_id': "6fdfa589-412c-489f-92fa-b472ee9fae7c",
                        'name': "activity_sample",
                        'user_id': "4f175f70-d192-42a4-bd74-6f5b5baf7963",
                        'activity_start': _parse_to_utc_iso8610(
                            "2020-05-15T14:30:25+00:00"),
                        'activity_end': _parse_to_utc_iso8610(
                            "2020-05-15T16:30:25+00:00"),
                        'category_id': '1',
                        'duration': 120.0,
                        }


def test__calculate_daily_average():
    sum_duration = float(320)
    time_window = float(3250)

    result = _calculate_daily_average(sum_duration, time_window)

    assert result == 106


def test__calculate_category_share():
    sum_duration = float(320)
    time_window = float(3250)

    result = _calculate_category_share(sum_duration, time_window)

    assert result == 0.09846153846153846
