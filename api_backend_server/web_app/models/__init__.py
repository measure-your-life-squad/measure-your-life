from mongoengine import (
    Document,
    UUIDField,
    StringField,
    BooleanField,
    ReferenceField,
    DateTimeField,
    IntField,
    EmailField,
    FloatField,
)


class Users(Document):
    public_id = UUIDField(binary=False, required=True, unique=True)
    username = StringField(max_length=50, unique=True)
    password = StringField(max_length=150)
    admin = BooleanField(default=False)
    email = EmailField(required=True, unique=True)
    email_confirmed = BooleanField(default=False)

    @staticmethod
    def get_specific_user(public_id: str) -> Document:
        (user,) = Users.objects(public_id=public_id)

        return user

    @staticmethod
    def delete_user(public_id: str) -> bool:
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

    @staticmethod
    def get_specific_category(category_id: str) -> Document:
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


class Activities(Document):
    activity_id = UUIDField(binary=False, required=True)
    name = StringField(max_length=50)
    user_id = UUIDField(binary=False)
    activity_start = DateTimeField()
    activity_end = DateTimeField()
    category = ReferenceField(Categories)
    duration = FloatField(min_value=0)

    @staticmethod
    def get_specific_activity(activity_id: str) -> Document:
        try:
            (activity,) = Activities.objects(activity_id=activity_id)
        except ValueError as e:
            if (
                len(e.args) > 0
                and e.args[0] == "not enough values to unpack (expected 1, got 0)"
            ):
                raise ValueError(
                    f"Activity with id={activity_id} does not exist in the Database"
                ) from e
            else:
                raise e

        return activity

    @staticmethod
    def delete_specific_activity(activity_id: str) -> bool:
        activity = Activities.get_specific_activity(activity_id=activity_id)

        activity.delete()

        return True

    @staticmethod
    def edit_specific_activity(activity_id: str, **kwargs: dict) -> Document:
        activity = Activities.get_specific_activity(activity_id=activity_id)

        updated_activity = activity.update(**kwargs)

        return updated_activity
