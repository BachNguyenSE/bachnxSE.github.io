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
import 'package:car_world_system/sources/repository/exchange_accessory_api_provider.dart';

class ExchangeAccessoryRepository {
  ExchangeAccessoryApiProvider exchangeAccessoryApiProvider =
      ExchangeAccessoryApiProvider();
  //create exchange accessory
  Future<bool> createExchangeAccessory(
      CreateExchangeAccessory exchangeAccessory) {
    return exchangeAccessoryApiProvider
        .createExchangeAccessory(exchangeAccessory);
  }

  //get all exchange accessory by user id
  Future<List<ExchangeAccessory>> getAllExchangeAccessoryByUserID(int id) {
    return exchangeAccessoryApiProvider.getListExchangeAccesoryByUserID(id);
  }

    Future<List<ExchangeAccessory>> getExchangeAccessoryToSell(int id) {
    return exchangeAccessoryApiProvider.getExchangeAccessoryToSell(id);
  }

    Future<List<UserExchangeToBuy>> getExchangeToBuy(int id) {
    return exchangeAccessoryApiProvider.getExchangeToBuy(id);
  }

  //get detail exchange accessory
  Future<ExchangeAccessory> getDetailExchangeAccessory(String id) {
    return exchangeAccessoryApiProvider.getExchangeAccessoryDetail(id);
  }

    //cancel exchange accessory
  Future<bool> cancelExchangeAccessory(String id) {
    return exchangeAccessoryApiProvider.cancelExchangeAccessory(id);
  }

//////////////////

    //create exchange car
  Future<bool> createExchangeCar(
      CreateExchangeCar exchangeCar) {
    return exchangeAccessoryApiProvider
        .createExchangeCar(exchangeCar);
  }

    //get all exchange car by user id
  Future<List<ExchangeCar>> getAllExchangeCarByUserID(int id) {
    return exchangeAccessoryApiProvider.getListExchangeCarByUserID(id);
  }

   Future<List<ExchangeCar>> getExchangeCarToSell(int id) {
    return exchangeAccessoryApiProvider.getExchangeCarToSell(id);
  }

  //get detail exchange car
  Future<ExchangeCar> getDetailExchangeCar(String id) {
    return exchangeAccessoryApiProvider.getExchangeCarDetail(id);
  }

    //cancel exchange accessory
  Future<bool> cancelExchangeCar(String id) {
    return exchangeAccessoryApiProvider.cancelExchangeCar(id);
  }
  ///////
     //get list exchange  by location
  Future<List<ExchangeCar>> getAllExchangeCarByLocation(int id) {
    return exchangeAccessoryApiProvider.getAllExchangeCarByLocation(id);
  }
   Future<List<ExchangeCar>> getAllExchangeCarByProvince(String provinceID, int id) {
    return exchangeAccessoryApiProvider.getAllExchangeCarByProvince(provinceID, id);
  }
   Future<List<ExchangeCar>> getAllExchangeCarByProvinceAndDistrict(String provinceID, String districtID, int id) {
    return exchangeAccessoryApiProvider.getAllExchangeCarByProvinceAndDistrict(provinceID, districtID, id);
  }

   Future<List<ExchangeAccessory>> getAllExchangeAccessoryByLocation(int id) {
    return exchangeAccessoryApiProvider.getAllExchangeAccessoryByLocation(id);
  }

    Future<List<ExchangeAccessory>> getAllExchangeAccessoryByProvince(String provinceID, int id) {
    return exchangeAccessoryApiProvider.getAllExchangeAccessoryByProvince(provinceID, id);
  }

    Future<List<ExchangeAccessory>> getAllExchangeAccessoryByProvinceAndDisitrict(String provinceID, String districtID, int id) {
    return exchangeAccessoryApiProvider.getAllExchangeAccessoryByProvinceAndDistrict(provinceID, districtID, id);
  }

// send exchange response
   Future<bool> sendExchangeResponeseCarAndAccessory(SendExchangeResponse exchangeResponse){
    return exchangeAccessoryApiProvider
        .sendExchangeResponeseCarAndAccessory(exchangeResponse);
  }

      //get list exchange car by location
  Future<List<UserExchangeResponse>> getListUserWanttoExchange(String id) {
    return exchangeAccessoryApiProvider.getListUserWanttoExchange(id);
  }


    Future<bool> acceptExchange(String exchangeID, int userID) {
    return exchangeAccessoryApiProvider.acceptExchange(exchangeID, userID);
  }

  Future<bool> sendFeedBackExchangeToSell(String id, FeedBack feedback){
    return exchangeAccessoryApiProvider.sendFeedBackExchangeToSell(id, feedback);
  }

   Future<bool> sendFeedBackExchangeToBuy(String id, FeedBack feedback){
    return exchangeAccessoryApiProvider.sendFeedBackExchangeToBuy(id, feedback);
  }


  Future<List<ListFeedback>> getListUserFeedback(int id) {
    return exchangeAccessoryApiProvider.getListUserFeedback(id);
  }


  Future<UserInformation> getBuyerAndSellerInfo(int id) {
    return exchangeAccessoryApiProvider.getBuyerAndSellerInfo(id);
  }
}
