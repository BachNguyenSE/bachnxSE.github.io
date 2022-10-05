import 'package:car_world_system/sources/model/list_User_EC.dart';
import 'package:car_world_system/sources/model/submit_check_list.dart';
import 'package:car_world_system/sources/repository/list_user_api_provider.dart';

class getListUserRepository {
  getListUserApiProvider getListUser = getListUserApiProvider();
  Future<List<userContestEvent>?> getListUSer(String id) {
    return getListUser.getListUserProvider(id);
  }

  Future<bool> submitListUser(CheckListUserCe listUser) {
    return getListUser.submitListUser(listUser);
  }
}
