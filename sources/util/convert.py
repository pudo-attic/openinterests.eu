from pytz import utc
from datetime import datetime
from dateutil.parser import parse


def as_date(dt):
    if not isinstance(dt, datetime):
        dt = parse(dt)
    return dt


def null_float(n):
    try:
        return float(n)
    except ValueError:
        return None
    except TypeError:
        return None

