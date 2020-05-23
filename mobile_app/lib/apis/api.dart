class API {
  static final String _basePath = 'http://150.254.30.252/api';

  static final String usersPath = _basePath + '/users';
  static final String activitiesPath = _basePath + '/activities';
  static final String categoriesPath = _basePath + '/categories';

  static final String statisticsPath = _basePath + '/statistics/meter';

  static final String registerUserUrl = usersPath + '/register';
  static final String loginUserUrl = usersPath + '/login';
}
