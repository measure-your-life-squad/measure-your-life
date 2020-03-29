import os
from pathlib import Path

import connexion


def server_setup():

    app = connexion.App(__name__, specification_dir="./")

    app.add_api("openapi.yaml")

    app.app.config["SECRET_KEY"] = os.getenv("SECRET_KEY", "very_very_secret_secret")
    app.app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv(
        "SQLALCHEMY_DATABASE_URI",
        "".join(["sqlite:////", str(Path.cwd().joinpath("local.db"))]),
    )
    app.app.config["SQLALCHAMY_TRACK_MODIFICATIONS"] = True

    return app


app = server_setup()
