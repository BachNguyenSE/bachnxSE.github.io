import 'package:car_world_system/sources/model/brand.dart';
import 'package:car_world_system/sources/model/interested_brand.dart';
import 'package:car_world_system/sources/model/update_interested_list_brand.dart';
import 'package:car_world_system/sources/repository/interested_brand_api_provider.dart';

class getListBrandRepository {
  getAllBrandApiProvider getListBrand = getAllBrandApiProvider();
  Future<List<Brand>?> getAllBrand() {
    return getListBrand.getAllBrandOfCars();
  }

  Future<bool> submitListUser(InterestedBrand listBrand) {
    return getListBrand.submitListUser(listBrand);
  }

  Future<List<UpdateInterestedListBrand>?> getAllBrandByUserId(int userId) {
    return getListBrand.getAllBrandOfCarsByUserId(userId);
  }
}
