import os
import uuid
from pathlib import Path

from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from werkzeug.security import generate_password_hash


engine = create_engine(
    "".join(["sqlite:////", str(Path.cwd().joinpath("local.db"))]), convert_unicode=True
)
db_session = scoped_session(
    sessionmaker(autocommit=False, autoflush=False, bind=engine)
)
Base = declarative_base()
Base.query = db_session.query_property()


def create_db_account(table, public_id, name, password, admin=False):
    new_user = table(public_id=public_id, name=name, password=password, admin=admin)
    db_session.add(new_user)
    db_session.commit()


def init_db():
    import models

    Base.metadata.create_all(bind=engine)

    adminpwd = os.getenv("DBADMINPWD", "security threat")
    dummyuserpwd = os.getenv("DUMMYUSERPWD", "minor security threat")

    admin_public_id = str(uuid.uuid4())
    user_public_id = str(uuid.uuid4())

    admin_name = "admin"
    user_name = "dummyuser"

    adm_password = generate_password_hash(adminpwd, method="sha256")
    usr_password = generate_password_hash(dummyuserpwd, method="sha256")

    create_db_account(models.Users, admin_public_id, admin_name, adm_password, admin=True)
    create_db_account(models.Users, user_public_id, user_name, usr_password, admin=False)
