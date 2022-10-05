import 'package:car_world_system/sources/model/car.dart';
import 'package:car_world_system/sources/model/car_generation.dart';
import 'package:car_world_system/sources/repository/car_api_provider.dart';

class CarRepository {
  CarAPIProvider carAPIProvider = CarAPIProvider();

  //get all car
  // Future<List<Car>> getListcar() {
  //   return carAPIProvider.getListCar();
  // }

  // //get all car by name
  // Future<List<Car>> getListCarByName(String name) {
  //   return carAPIProvider.getListCarByName(name);
  // }
  //   //get all car by  brand name
  // Future<List<Car>> getListCarByBrandName(String brandName) {
  //   return carAPIProvider.getListCarByBrandName(brandName);
  // }

  //get car detail by id
  Future<List<Car>> getCarDetail(String id) {
    return carAPIProvider.getCarDetail(id);
  }
   Future<List<CarGeneration>> getSearchCar(String id) {
    return carAPIProvider.getSearchCar(id);
  }

  Future<List<CarGeneration>> getAllCar() {
    return carAPIProvider.getAllCar();
  }
  Future<List<CarGeneration>> getAllCarByBrand(String id) {
    return carAPIProvider.getAllCarByBrand(id);
  }
}
