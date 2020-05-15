from typing import Tuple

from flask import jsonify, Response

from models import Categories


def get_available_categories(token_info: dict) -> Tuple[Response, int]:

    categories = Categories.objects.only("public_id", "name", "icon_name").exclude("id")

    return jsonify({"categories": categories})


def _get_specific_category(category_id: str) -> str:

    try:
        (category,) = Categories.objects(public_id=category_id)
    except ValueError as e:
        if (
            len(e.args) > 0
            and e.args[0] == "not enough values to unpack (expected 1, got 0)"
        ):
            raise ValueError(
                f"Category with id={category_id} does not exist in the Database"
            ) from e
        else:
            raise e

    return category
