from flask import jsonify

from models import Categories


def get_available_categories(token_info):

    categories = Categories.query.all()

    result = []

    for category in categories:
        category_data = {}
        category_data["id"] = category.id
        category_data["name"] = category.name
        category_data["icon_name"] = category.icon_name

        result.append(category_data)

    return jsonify({"categories": result})
