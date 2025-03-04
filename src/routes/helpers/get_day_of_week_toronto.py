from datetime import datetime
import pytz


def get_day_of_week_toronto(unix_time):
    # Create a timezone object for Toronto
    toronto_tz = pytz.timezone("America/Toronto")

    # Convert the Unix timestamp to a datetime object
    date_time = datetime.fromtimestamp(unix_time)

    # Apply the Toronto timezone to the datetime object
    date_time_toronto = toronto_tz.localize(date_time)

    # Get the day of the week as an integer (Monday = 0, Sunday = 6)
    day_of_week = date_time_toronto.weekday()

    return day_of_week + 1
