const String BASE_URL = "https://carworld.cosplane.asia";

class LoginApiString {
  //https://carworld.cosplane.asia/api/user/LoginUser
  static String login() {
    return BASE_URL + '/api/user/LoginUser';
  }

  static String getProfile(String email) {
    return BASE_URL + '/api/user/GetUserByEmail?email=$email';
  }

  static String loginAdmin() {
    return BASE_URL + '/api/user/LoginAdmin';
  }
}
