from mongoengine import (
    Document,
    UUIDField,
    StringField,
    BooleanField,
    ReferenceField,
    DateTimeField,
    IntField,
    EmailField,
)


class Users(Document):
    public_id = UUIDField(binary=False, required=True, unique=True)
    username = StringField(max_length=50, unique=True)
    password = StringField(max_length=150)
    admin = BooleanField(default=False)
    email = EmailField(required=True, unique=True)
    email_confirmed = BooleanField(default=False)

    @staticmethod
    def delete_user(public_id):
        (user,) = Users.objects(public_id=public_id)
        user.delete()

    @staticmethod
    def validate_if_existing_user(**kwargs):
        try:
            (user,) = Users.objects(**kwargs)
        except ValueError as e:
            if (
                len(e.args) > 0
                and e.args[0] == "not enough values to unpack (expected 1, got 0)"
            ):
                return False
        else:
            return True


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
