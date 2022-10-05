import 'package:car_world_system/sources/model/submit_check_list.dart';

const String BASE_URL = "https://carworld.cosplane.asia";

class GetApiString {
  //update profile
  // https://carworld.cosplane.asia/api/user/UpdateProfile?id=
  static String getUsersInCE(String id) {
    return BASE_URL + '/api/ceRegister/GetUsersInCE?contestEventId=$id';
  }

  static String CheckInUsers() {
    return BASE_URL + '/api/ceRegister/CheckInUsers';
  }
}
