import os
import uuid

from werkzeug.security import generate_password_hash

from app import db
from app import Users


adminpwd = os.getenv("DBADMINPWD", "security threat")

db.create_all()

public_id = str(uuid.uuid4())
name = "admin"
password = generate_password_hash(adminpwd, method="sha256")


admin_user = Users(public_id=public_id, name=name, password=password, admin=True)

db.session.add(admin_user)
db.session.commit()
