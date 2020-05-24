class API {
  static final String _basePath = 'http://10.0.2.2/api';

  static final String usersPath = _basePath + '/users';
  static final String activitiesPath = _basePath + '/activities';
  static final String categoriesPath = _basePath + '/categories';

  static final String statisticsPath = _basePath + '/statistics/meter';
  static final String oldestdatePath = _basePath + '/statistics/oldest';

  static final String registerUserUrl = usersPath + '/register';
  static final String loginUserUrl = usersPath + '/login';
}
