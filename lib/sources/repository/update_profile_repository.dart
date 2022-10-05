import 'package:car_world_system/sources/model/userProfile.dart';
import 'package:car_world_system/sources/repository/update_profile_api_provider.dart';

class UpdateProfileRepository {
  UpdateProfileApiProvider updateProfileApiProvider =
      UpdateProfileApiProvider();

  Future<bool> updateProfile(UserProfile userProfile) {
    return updateProfileApiProvider.updateProfile(userProfile);
  }
}
