from uuid import UUID
import re


def is_valid_uuid(id_to_test):
    try:
        UUID(str(id_to_test))
        return True
    except ValueError:
        return False


def is_valid_jwt(token_to_test):

    match = re.search(
        r"^[A-Za-z0-9-_=]+\.[A-Za-z0-9-_=]+\.[A-Za-z0-9-_.+/=]*$",
        token_to_test
    )

    return bool(match)
