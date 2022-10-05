import 'dart:convert';

import 'package:car_world_system/sources/model/car.dart';
import 'package:car_world_system/sources/model/car_generation.dart';
import 'package:car_world_system/sources/repository/car_api_string.dart';
import 'package:http/http.dart' as http;

class CarAPIProvider {
  // get all car
  // Future<List<Car>> getListCar() async {
  //   final response = await http.get(Uri.parse(CarApiString.getListCar()));
  //   List<Car> listCar = [];
  //   var jsonData = jsonDecode(response.body);
  //   for (var data in jsonData) {
  //     if (data['IsDeleted'] == false) {
  //       Car car = Car(
  //         id: data['Id'],
  //         name: data['Name'],
  //         brandId: data['BrandId'],
  //         despcription: data['Despcription'],
  //         yearOfManufactor: data['YearOfManufactor'],
  //         price: data['Price'],
  //         bodyType: data['BodyType'],
  //         origin: data['Origin'],
  //         length: data['Length'],
  //         width: data['Width'],
  //         height: data['Height'],
  //         displacement: data['Displacement'],
  //         engineType: data['EngineType'],
  //         maxPower: data['MaxPower'],
  //         maxTorque: data['MaxTorque'],
  //         groundClearance: data['GroundClearance'],
  //         turningRadius: data['TurningRadius'],
  //         fuelConsumption: data['FuelConsumption'],
  //         gearBox: data['GearBox'],
  //         seats: data['Seats'],
  //         kerbWeight: data['KerbWeight'],
  //         fuelCapacity: data['FuelCapacity'],
  //         wheelSize: data['WheelSize'],
  //         tyreSize: data['TyreSize'],
  //         frontSuspension: data['FrontSuspension'],
  //         rearSuspension: data['RearSuspension'],
  //         interiorMaterial: data['InteriorMaterial'],
  //         headLights: data['HeadLights'],
  //         tailLights: data['TailLights'],
  //         fogLamps: data['FogLamps'],
  //         image: data['Image'],
  //         createdDate: data['CreatedDate'],
  //         isDeleted: data['IsDeleted'],
  //         // brand: data['Brand'],
  //       );
  //       listCar.add(car);
  //     }
  //   }

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON
  //     return listCar;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load list car');
  //   }
  // }

  // // get all car by name
  // Future<List<Car>> getListCarByName(String name) async {
  //   final response =
  //       await http.get(Uri.parse(CarApiString.getListCarByName(name)));
  //   List<Car> listCar = [];
  //   var jsonData = jsonDecode(response.body);
  //   for (var data in jsonData) {
  //     if (data['IsDeleted'] == false) {
  //       Car car = Car(
  //         id: data['Id'],
  //         name: data['Name'],
  //         brandId: data['BrandId'],
  //         despcription: data['Despcription'],
  //         yearOfManufactor: data['YearOfManufactor'],
  //         price: data['Price'],
  //         bodyType: data['BodyType'],
  //         origin: data['Origin'],
  //         length: data['Length'],
  //         width: data['Width'],
  //         height: data['Height'],
  //         displacement: data['Displacement'],
  //         engineType: data['EngineType'],
  //         maxPower: data['MaxPower'],
  //         maxTorque: data['MaxTorque'],
  //         groundClearance: data['GroundClearance'],
  //         turningRadius: data['TurningRadius'],
  //         fuelConsumption: data['FuelConsumption'],
  //         gearBox: data['GearBox'],
  //         seats: data['Seats'],
  //         kerbWeight: data['KerbWeight'],
  //         fuelCapacity: data['FuelCapacity'],
  //         wheelSize: data['WheelSize'],
  //         tyreSize: data['TyreSize'],
  //         frontSuspension: data['FrontSuspension'],
  //         rearSuspension: data['RearSuspension'],
  //         interiorMaterial: data['InteriorMaterial'],
  //         headLights: data['HeadLights'],
  //         tailLights: data['TailLights'],
  //         fogLamps: data['FogLamps'],
  //         image: data['Image'],
  //         createdDate: data['CreatedDate'],
  //         isDeleted: data['IsDeleted'],
  //         // brand: data['Brand'],
  //       );
  //       listCar.add(car);
  //     }
  //   }

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON
  //     return listCar;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load list car by name');
  //   }
  // }

  // // get all car by brand name
  // Future<List<Car>> getListCarByBrandName(String brandName) async {
  //   final response = await http
  //       .get(Uri.parse(CarApiString.getListCarByBrandName(brandName)));
  //   List<Car> listCar = [];
  //   var jsonData = jsonDecode(response.body);
  //   for (var data in jsonData) {
  //     if (data['IsDeleted'] == false) {
  //       Car car = Car(
  //         id: data['Id'],
  //         name: data['Name'],
  //         brandId: data['BrandId'],
  //         despcription: data['Despcription'],
  //         yearOfManufactor: data['YearOfManufactor'],
  //         price: data['Price'],
  //         bodyType: data['BodyType'],
  //         origin: data['Origin'],
  //         length: data['Length'],
  //         width: data['Width'],
  //         height: data['Height'],
  //         displacement: data['Displacement'],
  //         engineType: data['EngineType'],
  //         maxPower: data['MaxPower'],
  //         maxTorque: data['MaxTorque'],
  //         groundClearance: data['GroundClearance'],
  //         turningRadius: data['TurningRadius'],
  //         fuelConsumption: data['FuelConsumption'],
  //         gearBox: data['GearBox'],
  //         seats: data['Seats'],
  //         kerbWeight: data['KerbWeight'],
  //         fuelCapacity: data['FuelCapacity'],
  //         wheelSize: data['WheelSize'],
  //         tyreSize: data['TyreSize'],
  //         frontSuspension: data['FrontSuspension'],
  //         rearSuspension: data['RearSuspension'],
  //         interiorMaterial: data['InteriorMaterial'],
  //         headLights: data['HeadLights'],
  //         tailLights: data['TailLights'],
  //         fogLamps: data['FogLamps'],
  //         image: data['Image'],
  //         createdDate: data['CreatedDate'],
  //         isDeleted: data['IsDeleted'],
  //         // brand: data['Brand'],
  //       );
  //       listCar.add(car);
  //     }
  //   }

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON
  //     return listCar;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load list car by brand name');
  //   }
  // }

  //get car detail by id
  Future<List<Car>> getCarDetail(String id) async {
    final response = await http.get(Uri.parse(CarApiString.getCarDetail(id)));
    List<Car> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      Car car = Car.fromJson(data);
      list.add(car);
    }
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list car detail');
    }
  }

  Future<List<CarGeneration>> getSearchCar(String id) async {
    final response = await http.get(Uri.parse(CarApiString.getSearchCar(id)));
    List<CarGeneration> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      CarGeneration district = CarGeneration.fromJson(data);
      list.add(district);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list tim xe');
    }
  }

  Future<List<CarGeneration>> getAllCar() async {
    final response = await http.get(Uri.parse(CarApiString.getAllCar()));
    List<CarGeneration> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      CarGeneration district = CarGeneration.fromJson(data);
      list.add(district);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list tim xe');
    }
  }

  Future<List<CarGeneration>> getAllCarByBrand(String id) async {
    final response =
        await http.get(Uri.parse(CarApiString.getAllCarByBrand(id)));
    List<CarGeneration> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      CarGeneration district = CarGeneration.fromJson(data);
      list.add(district);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list tim xe');
    }
  }
}
