const String BASE_URL = "https://carworld.cosplane.asia";

class UpdateProfileString {
  //update profile
  // https://carworld.cosplane.asia/api/user/UpdateProfile?id=
  static String updateProfile(int id) {
    return BASE_URL + '/api/user/UpdateProfile?id=$id';
  }
}
