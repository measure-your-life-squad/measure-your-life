from api_backend_server.web_app.apis.users import save_user
from api_backend_server.web_app.models import Users


import pytest
from mongoengine import connect


@pytest.fixture(scope='function')
def mongo(request):
    db = connect('mongoenginetest', host='mongomock://localhost')
    yield db
    db.drop_database('mongoenginetest')
    db.close()


def test_save_user_should_succeed(mongo):
    fresh_user_save = save_user(public_id='3b241101-e2bb-4255-8caf-4136c566a962',
                                username='testusername',
                                password='testpassword',
                                email='testmail@mail.com')

    fresh_user2_save = save_user(public_id='3b241101-e2bb-4255-8caf-4136c566a964',
                                 username='2testusername2',
                                 password='testpassword',
                                 email='2testmail2@mail.com')

    fresh_user = Users.objects().first()

    assert fresh_user.username == 'testusername'

    assert fresh_user_save['payload'] == {"message": "registered successfuly",
                                          "user_id":
                                          '3b241101-e2bb-4255-8caf-4136c566a962'}
    assert fresh_user_save['http_code'] == 200
    assert fresh_user2_save['payload'] == {"message": "registered successfuly",
                                           "user_id":
                                           '3b241101-e2bb-4255-8caf-4136c566a964'}
    assert fresh_user2_save['http_code'] == 200


def test_save_user_not_unique_error_username(mongo):

    fresh_user = save_user(public_id='3b241101-e2bb-4255-8caf-4136c566a964',
                           username='testusername',
                           password='testpassword',
                           email='1testmail1@mail.com')

    repeated_user = save_user(public_id='3b241101-e2bb-4255-8caf-4136c566a964',
                              username='testusername',
                              password='testpassword',
                              email='2testmail2@mail.com')

    assert fresh_user['payload'] == {"message": "registered successfuly",
                                     "user_id":
                                     '3b241101-e2bb-4255-8caf-4136c566a964'}
    assert fresh_user['http_code'] == 200
    assert repeated_user['payload'] == {
        "message": "username or email address already in use"}
    assert repeated_user['http_code'] == 409


def test_save_user_not_unique_error_email(mongo):

    fresh_user = save_user(public_id='3b241101-e2bb-4255-8caf-4136c566a964',
                           username='1testusername1',
                           password='testpassword',
                           email='testmail@mail.com')

    repeated_user = save_user(public_id='3b241101-e2bb-4255-8caf-4136c566a964',
                              username='2testusername2',
                              password='testpassword',
                              email='testmail@mail.com')

    assert fresh_user['payload'] == {"message": "registered successfuly",
                                     "user_id":
                                     '3b241101-e2bb-4255-8caf-4136c566a964'}
    assert fresh_user['http_code'] == 200
    assert repeated_user['payload'] == {
        "message": "username or email address already in use"}
    assert repeated_user['http_code'] == 409


def test_save_user_validation_error(mongo):

    fresh_user = save_user(public_id='3b241101-e2bb-4255-8caf-4136c566a964',
                           username='testusername',
                           password='testpassword',
                           email='testmailmail.com')

    assert fresh_user['payload'] == {
        "message": f"invalid email address: testmailmail.com"}
    assert fresh_user['http_code'] == 422
