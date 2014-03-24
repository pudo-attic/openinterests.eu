


def null_float(n):
    try:
        return float(n)
    except ValueError:
        return None
    except TypeError:
        return None

