import 'dart:convert';

import 'package:car_world_system/sources/model/create_exchange_accessory.dart';
import 'package:car_world_system/sources/model/create_exchange_car.dart';
import 'package:car_world_system/sources/model/exchange_accessory.dart';
import 'package:car_world_system/sources/model/exchange_car.dart';
import 'package:car_world_system/sources/model/feedback.dart';
import 'package:car_world_system/sources/model/list_feedback.dart';
import 'package:car_world_system/sources/model/send_exchange_response.dart';
import 'package:car_world_system/sources/model/user_exchange_response.dart';
import 'package:car_world_system/sources/model/user_exchange_to_buy.dart';
import 'package:car_world_system/sources/model/user_information.dart';
import 'package:car_world_system/sources/repository/exchange_accessory_api_string.dart';
import 'package:http/http.dart' as http;

class ExchangeAccessoryApiProvider {
  //create exchange accessory
  Future<bool> createExchangeAccessory(
      CreateExchangeAccessory exchangeAccessory) async {
    final response = await http.post(
      Uri.parse(ExchangeAccessoryApiString.createExchangeAccessory()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(exchangeAccessory),
    );
    if (response.statusCode == 200) {
      print("thanh cong");

      print(response.body);
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      throw Exception('Failed to user create exchange accessory.');
      // return false;

    }
  }

  //get list exchange accessory by user id
  Future<List<ExchangeAccessory>> getListExchangeAccesoryByUserID(
      int id) async {
    final response = await http.get(Uri.parse(
        ExchangeAccessoryApiString.getAllExchangeAccessoryByUserID(id)));
    List<ExchangeAccessory> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      // if (data['Type'] == 2) {
      //sử dung kiểu này khi có object ở trong json
      ExchangeAccessory exchangeAccessory = ExchangeAccessory.fromJson(data);
      list.add(exchangeAccessory);
      //}
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list exchange accessory by user id');
    }
  }

  Future<List<ExchangeAccessory>> getExchangeAccessoryToSell(int id) async {
    final response = await http.get(
        Uri.parse(ExchangeAccessoryApiString.getExchangeAccessoryToSell(id)));
    List<ExchangeAccessory> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      // if (data['Type'] == 2) {
      //sử dung kiểu này khi có object ở trong json
      ExchangeAccessory exchangeAccessory = ExchangeAccessory.fromJson(data);
      list.add(exchangeAccessory);
      //}
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list exchange accessory to sell');
    }
  }

  //get exchange accessory detail by id
  Future<ExchangeAccessory> getExchangeAccessoryDetail(String id) async {
    final response = await http.get(
        Uri.parse(ExchangeAccessoryApiString.getDetailExchangeAccessory(id)));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return ExchangeAccessory.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load exchange accessory detail');
    }
  }

  //cancel exchange accessory
  Future<bool> cancelExchangeAccessory(String id) async {
    final response = await http.put(
      Uri.parse(ExchangeAccessoryApiString.cancelExchangeAccessory(id)),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      // body: json.encode(userEvent),
    );
    print("vao ham huy");
    print("code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("thanh cong hủy exchange accessory");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

//////////
  //create exchange car
  Future<bool> createExchangeCar(CreateExchangeCar exchangeCar) async {
    print("vao tao trao doi xe");
    final response = await http.post(
      Uri.parse(ExchangeAccessoryApiString.createExchangeCar()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(exchangeCar),
    );
    print("code: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("thanh cong");

      print(response.body);
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      throw Exception('Failed to user create exchange car.');
      // return false;

    }
  }

  //get list exchange car by user id
  Future<List<ExchangeCar>> getListExchangeCarByUserID(int id) async {
    final response = await http.get(
        Uri.parse(ExchangeAccessoryApiString.getAllExchangeCarByUserID(id)));
    List<ExchangeCar> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      ExchangeCar exchangeCar = ExchangeCar.fromJson(data);
      list.add(exchangeCar);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list exchange car by user id');
    }
  }

  Future<List<ExchangeCar>> getExchangeCarToSell(int id) async {
    final response = await http
        .get(Uri.parse(ExchangeAccessoryApiString.getExchangeCarToSell(id)));
    List<ExchangeCar> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      ExchangeCar exchangeCar = ExchangeCar.fromJson(data);
      list.add(exchangeCar);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list exchange car to sell ');
    }
  }

  //get exchange car detail by id
  Future<ExchangeCar> getExchangeCarDetail(String id) async {
    final response = await http
        .get(Uri.parse(ExchangeAccessoryApiString.getDetailExchangeCar(id)));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return ExchangeCar.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load exchange car detail');
    }
  }

  //cancel exchange car
  Future<bool> cancelExchangeCar(String id) async {
    final response = await http.put(
      Uri.parse(ExchangeAccessoryApiString.cancelExchangeCar(id)),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      // body: json.encode(userEvent),
    );
    print("vao ham huy");
    print("code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("thanh cong hủy exchange car");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  ////
  //get list exchange car by location
  Future<List<ExchangeCar>> getAllExchangeCarByLocation(int id) async {
    final response = await http.get(
        Uri.parse(ExchangeAccessoryApiString.getAllExchangeCarByLocation(id)));
    List<ExchangeCar> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      ExchangeCar exchangeCar = ExchangeCar.fromJson(data);
      list.add(exchangeCar);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list exchange car by location');
    }
  }

  Future<List<ExchangeCar>> getAllExchangeCarByProvince(
      String provinceID, int id) async {
    final response = await http.get(Uri.parse(
        ExchangeAccessoryApiString.getAllExchangeCarByProvince(
            provinceID, id)));
    List<ExchangeCar> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      ExchangeCar exchangeCar = ExchangeCar.fromJson(data);
      list.add(exchangeCar);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list exchange car by province');
    }
  }

  Future<List<ExchangeCar>> getAllExchangeCarByProvinceAndDistrict(
      String provinceID, String districtID, int id) async {
    final response = await http.get(Uri.parse(
        ExchangeAccessoryApiString.getAllExchangeCarByProvinceAndDistrict(
            provinceID, districtID, id)));
    List<ExchangeCar> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      ExchangeCar exchangeCar = ExchangeCar.fromJson(data);
      list.add(exchangeCar);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load list exchange car by province and district');
    }
  }

  //get list exchange accessory by location
  Future<List<ExchangeAccessory>> getAllExchangeAccessoryByLocation(
      int id) async {
    final response = await http.get(Uri.parse(
        ExchangeAccessoryApiString.getAllExchangeAccessoryByLocation(id)));
    List<ExchangeAccessory> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      ExchangeAccessory exchangeAccessory = ExchangeAccessory.fromJson(data);
      list.add(exchangeAccessory);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list exchange accessory by location');
    }
  }

  Future<List<ExchangeAccessory>> getAllExchangeAccessoryByProvince(
      String provinceID, int id) async {
    final response = await http.get(Uri.parse(
        ExchangeAccessoryApiString.getAllExchangeAccessoryByProvince(
            provinceID, id)));
    List<ExchangeAccessory> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      ExchangeAccessory exchangeAccessory = ExchangeAccessory.fromJson(data);
      list.add(exchangeAccessory);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list exchange accessory by province');
    }
  }

  Future<List<ExchangeAccessory>> getAllExchangeAccessoryByProvinceAndDistrict(
      String provinceID, String districtID, int id) async {
    final response = await http.get(Uri.parse(
        ExchangeAccessoryApiString.getAllExchangeAccessoryByProvinceAndDistrict(
            provinceID, districtID, id)));
    List<ExchangeAccessory> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      ExchangeAccessory exchangeAccessory = ExchangeAccessory.fromJson(data);
      list.add(exchangeAccessory);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception(
          'Failed to load list exchange accessory by province and district');
    }
  }

  //send exchange response
  Future<bool> sendExchangeResponeseCarAndAccessory(
      SendExchangeResponse exchangeResponse) async {
    print("vao gui thong tin trao doi xe");
    final response = await http.post(
      Uri.parse(
          ExchangeAccessoryApiString.sendExchangeResponeseCarAndAccessory()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(exchangeResponse),
    );
    print("code: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      // print("thanh cong gui thong tin de trao doi xe");

      // print(response.body);
      return true;
    } else {
      
      
    return false;

    }
  }

  //get list want to exchange response
  Future<List<UserExchangeResponse>> getListUserWanttoExchange(
      String id) async {
    final response = await http.get(
        Uri.parse(ExchangeAccessoryApiString.getListUserWanttoExchange(id)));
    List<UserExchangeResponse> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      UserExchangeResponse listUserExchange =
          UserExchangeResponse.fromJson(data);
      list.add(listUserExchange);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list want to exchange response');
    }
  }

  Future<bool> acceptExchange(String exchangeID, int userID) async {
    final response = await http.put(Uri.parse(
        ExchangeAccessoryApiString.acceptExchange(exchangeID, userID)));
    print("vao ham chap nhận trao dổi");
    print("code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("thanh cong trao dổi món hàng");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  Future<bool> sendFeedBackExchangeToSell(String id, FeedBack feedBack) async {
    final response = await http.post(
      Uri.parse(ExchangeAccessoryApiString.sendFeedBackExchangeToSell(id)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(feedBack),
    );

    if (response.statusCode == 200) {
      print("thanh cong gửi feedback ve mon hang da ban");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  Future<bool> sendFeedBackExchangeToBuy(String id, FeedBack feedBack) async {
    final response = await http.post(
      Uri.parse(ExchangeAccessoryApiString.sendFeedBackExchangeToBuy(id)),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(feedBack),
    );

    if (response.statusCode == 200) {
      print("thanh cong gửi feedback ve mon hang da mua");
      return true;
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      return false;
    }
  }

  Future<List<UserExchangeToBuy>> getExchangeToBuy(int id) async {
    final response = await http
        .get(Uri.parse(ExchangeAccessoryApiString.getExchangeToBuy(id)));
    List<UserExchangeToBuy> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      UserExchangeToBuy listUserExchange = UserExchangeToBuy.fromJson(data);
      list.add(listUserExchange);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list exchange user to buy');
    }
  }

  Future<List<ListFeedback>> getListUserFeedback(int id) async {
    final response = await http
        .get(Uri.parse(ExchangeAccessoryApiString.getListUserFeedback(id)));
    List<ListFeedback> list = [];
    var jsonData = jsonDecode(response.body);
    for (var data in jsonData) {
      //sử dung kiểu này khi có object ở trong json
      ListFeedback listFeedback = ListFeedback.fromJson(data);
      list.add(listFeedback);
      // }
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return list;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load list feedback of user');
    }
  }

  Future<UserInformation> getBuyerAndSellerInfo(int id) async {
    final response = await http
        .get(Uri.parse(ExchangeAccessoryApiString.getBuyerAndSellerInfo(id)));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON
      return UserInformation.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load UserInformation');
    }
  }
}
