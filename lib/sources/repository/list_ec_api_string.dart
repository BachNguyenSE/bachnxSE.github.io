import 'package:car_world_system/sources/model/submit_check_list.dart';

const String BASE_URL = "https://carworld.cosplane.asia";

class GetListECApiString {
  //update profile
  // https://carworld.cosplane.asia/api/user/UpdateProfile?id=
  static String getListEventContestNow(int type, String now) {
    return BASE_URL + '/api/contestEvent/GetOngoingCEs?type=$type&now=$now';
  }
}
