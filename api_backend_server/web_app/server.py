import os

import connexion


def server_setup() -> connexion.App:
    """Server factory for a Flask application in connextion App wrapper"""

    app = connexion.App(__name__, specification_dir="./")

    app.add_api("openapi.yaml")

    app.app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")

    app.app.config["SECURITY_PASSWORD_SALT"] = os.getenv("SECURITY_PASSWORD_SALT")

    app.app.config["MONGODB_SETTINGS"] = {
        "db": os.getenv("MONGODBNAME", "mongodev"),
        "host": "mongo",
        "port": 27017,
        "username": os.getenv("APISERVERUSR"),
        "password": os.getenv("APISERVERPWD"),
    }

    return app


app = server_setup()
