from mongoengine import (
    Document,
    UUIDField,
    StringField,
    BooleanField,
    ReferenceField,
    DateTimeField,
    IntField,
)


class Users(Document):
    public_id = UUIDField(binary=False, required=True, unique=True)
    name = StringField(max_length=50, unique=True)
    password = StringField(max_length=150)
    admin = BooleanField(default=False)


class Categories(Document):
    public_id = IntField(required=True, unique=True)
    name = StringField(max_length=50)
    icon_name = StringField(max_length=50)


class Activities(Document):
    activity_id = UUIDField(binary=False, required=True)
    name = StringField(max_length=50)
    user_id = UUIDField(binary=False)
    activity_start = DateTimeField()
    activity_end = DateTimeField()
    category = ReferenceField(Categories)
