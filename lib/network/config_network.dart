const String baseUrl = 'https://biike-api.azurewebsites.net';

class EndPoint {
  static const String signup = '/api/biike/v1/users';

  static const String signin = '/api/biike/v1/users/login';

  static const String userVerify = '/api/biike/v1/users';

  static const String blackList = '/api/biike/v1/intimacies';

  static const String advertisements = '/api/biike/v1/advertisements?page=1&limit=10';
  static const String advertisementsCount = '/api/biike/v1/advertisements';
}
