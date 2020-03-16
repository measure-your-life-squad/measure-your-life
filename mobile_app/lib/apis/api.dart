class API {
  static final String _basePath = 'http://0.0.0.0:5000/api';

  static final String usersPath = _basePath + '/users';
  static final String activitiesPath = _basePath + '/activities';

  static final String registerUserUrl = usersPath + '/register';
  static final String loginUserUrl = usersPath + '/login';
}
