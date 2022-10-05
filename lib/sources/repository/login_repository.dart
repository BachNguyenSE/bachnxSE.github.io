import 'package:car_world_system/sources/model/userLogin.dart';
import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/model/user_information.dart';
import 'package:car_world_system/sources/repository/login_api_provider.dart';

class LoginRepository {
  LoginApiProvider loginApiProvider = LoginApiProvider();
  Future<bool> login(UserLogin user) {
    return loginApiProvider.login(user);
  }

  Future<UserProfile> getProfile(String email) {
    return loginApiProvider.getProfile(email);
  }

  Future<UserInformation> getUserInformation(String email) {
    return loginApiProvider.getUserInformation(email);
  }

  Future<bool> loginAdmin(String username, String password) {
    return loginApiProvider.loginAdmin(username, password);
  }
}
