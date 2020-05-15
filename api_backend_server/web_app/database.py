import connexion
from flask_mongoengine import MongoEngine


db = MongoEngine()


def initialize_db(app: connexion.App) -> None:
    db.init_app(app)
