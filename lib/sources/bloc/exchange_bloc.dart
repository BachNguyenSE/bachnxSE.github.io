import 'package:car_world_system/sources/model/exchange_accessory.dart';
import 'package:car_world_system/sources/model/exchange_car.dart';
import 'package:car_world_system/sources/model/list_feedback.dart';
import 'package:car_world_system/sources/model/user_exchange_response.dart';
import 'package:car_world_system/sources/model/user_exchange_to_buy.dart';
import 'package:car_world_system/sources/model/user_information.dart';
import 'package:car_world_system/sources/repository/exchange_accessory_repository.dart';
import 'package:rxdart/rxdart.dart';

class ExchangeBloc {
  final ExchangeAccessoryRepository exchangeAccessoryRepository =
      ExchangeAccessoryRepository();

  final _listExchangeAccessoryOfUserFetcher =
      PublishSubject<List<ExchangeAccessory>>();
  final _exchangeAccessoryDetailOfUserFetcher =
      PublishSubject<ExchangeAccessory>();

  final _listExchangeCarOfUserFetcher = PublishSubject<List<ExchangeCar>>();
  final _exchangeCarDetailOfUserFetcher = PublishSubject<ExchangeCar>();
//
  final _listUserExchangeResponseFetcher =
      PublishSubject<List<UserExchangeResponse>>();

  Observable<List<UserExchangeResponse>> get listUserExchangeResponse =>
      _listUserExchangeResponseFetcher.stream;

  final _listUserExchangeToBuyFetcher =
      PublishSubject<List<UserExchangeToBuy>>();

  Observable<List<UserExchangeToBuy>> get listUserExchangeToBuy =>
      _listUserExchangeToBuyFetcher.stream;
//

  Observable<List<ExchangeAccessory>> get listExchangeAccessoryOfUser =>
      _listExchangeAccessoryOfUserFetcher.stream;
  Observable<ExchangeAccessory> get exchangeAccessoryDetail =>
      _exchangeAccessoryDetailOfUserFetcher.stream;

  Observable<List<ExchangeCar>> get listExchangeCarOfUser =>
      _listExchangeCarOfUserFetcher.stream;
  Observable<ExchangeCar> get exchangeCarDetail =>
      _exchangeCarDetailOfUserFetcher.stream;


 final _listUserFeedbackFetcher =
      PublishSubject<List<ListFeedback>>();

  Observable<List<ListFeedback>> get listUserFeedback =>
      _listUserFeedbackFetcher.stream;

  //get list exchange accessory by user id
  getListExchangeAccessoryOfUser(int id) async {
    List<ExchangeAccessory> list =
        await exchangeAccessoryRepository.getAllExchangeAccessoryByUserID(id);
    _listExchangeAccessoryOfUserFetcher.sink.add(list);
  }

  getExchangeAccessoryToSell(int id) async {
    List<ExchangeAccessory> list =
        await exchangeAccessoryRepository.getExchangeAccessoryToSell(id);
    _listExchangeAccessoryOfUserFetcher.sink.add(list);
  }

  getExchangeToBuy(int id) async {
    List<UserExchangeToBuy> list =
        await exchangeAccessoryRepository.getExchangeToBuy(id);
    _listUserExchangeToBuyFetcher.sink.add(list);
  }
  //get list exchange car by user id
  getListExchangeCarOfUser(int id) async {
    List<ExchangeCar> list =
        await exchangeAccessoryRepository.getAllExchangeCarByUserID(id);
    _listExchangeCarOfUserFetcher.sink.add(list);
  }

  getExchangeCarToSell(int id) async {
    List<ExchangeCar> list =
        await exchangeAccessoryRepository.getExchangeCarToSell(id);
    _listExchangeCarOfUserFetcher.sink.add(list);
  }

  //get event detail by id
  getExchangeAccessoryDetail(String id) async {
    ExchangeAccessory exchangeAccessoryDetail =
        await exchangeAccessoryRepository.getDetailExchangeAccessory(id);
    _exchangeAccessoryDetailOfUserFetcher.sink.add(exchangeAccessoryDetail);
  }

  //get event detail by id
  getExchangeCarDetail(String id) async {
    ExchangeCar exchangeAccessoryDetail =
        await exchangeAccessoryRepository.getDetailExchangeCar(id);
    _exchangeCarDetailOfUserFetcher.sink.add(exchangeAccessoryDetail);
  }

//
  //get list exchange car by location
  getAllExchangeCarByLocation(int id) async {
    List<ExchangeCar> list =
        await exchangeAccessoryRepository.getAllExchangeCarByLocation(id);
    _listExchangeCarOfUserFetcher.sink.add(list);
  }

  getAllExchangeCarByProvince(String provinceID, int id) async {
    List<ExchangeCar> list = await exchangeAccessoryRepository
        .getAllExchangeCarByProvince(provinceID, id);
    _listExchangeCarOfUserFetcher.sink.add(list);
  }

  getAllExchangeCarByProvinceAndDistrict(
      String provinceID, String districtID, int id) async {
    List<ExchangeCar> list = await exchangeAccessoryRepository
        .getAllExchangeCarByProvinceAndDistrict(provinceID, districtID, id);
    _listExchangeCarOfUserFetcher.sink.add(list);
  }

  //get list exchange car by location
  getAllExchangeAccessoryByLocation(int id) async {
    List<ExchangeAccessory> list =
        await exchangeAccessoryRepository.getAllExchangeAccessoryByLocation(id);
    _listExchangeAccessoryOfUserFetcher.sink.add(list);
  }

  getAllExchangeAccessoryByProvince(String provinceID, int id) async {
    List<ExchangeAccessory> list = await exchangeAccessoryRepository
        .getAllExchangeAccessoryByProvince(provinceID, id);
    _listExchangeAccessoryOfUserFetcher.sink.add(list);
  }

  getAllExchangeAccessoryByProvinceAndDistrict(
      String provinceID, String districtID, int id) async {
    List<ExchangeAccessory> list = await exchangeAccessoryRepository
        .getAllExchangeAccessoryByProvinceAndDisitrict(provinceID, districtID, id);
    _listExchangeAccessoryOfUserFetcher.sink.add(list);
  }

  //get list user  exchange response
  getListUserWattoExchange(String id) async {
    List<UserExchangeResponse> list =
        await exchangeAccessoryRepository.getListUserWanttoExchange(id);
    _listUserExchangeResponseFetcher.sink.add(list);
  }


getListUserFeedback(int id) async {
    List<ListFeedback> list =
        await exchangeAccessoryRepository.getListUserFeedback(id);
    _listUserFeedbackFetcher.sink.add(list);
  }



  
final _buyerAndSellerInfoFetcher = PublishSubject<UserInformation>();
Observable<UserInformation> get buyerAndSellerInfo =>
      _buyerAndSellerInfoFetcher.stream;

  getBuyerAndSellerInfo(int id) async {
    UserInformation userInformation =
        await exchangeAccessoryRepository.getBuyerAndSellerInfo(id);
    _buyerAndSellerInfoFetcher.sink.add(userInformation);
  }
      
  dispose() {
    _buyerAndSellerInfoFetcher.close();
    _listExchangeAccessoryOfUserFetcher.close();
    _exchangeAccessoryDetailOfUserFetcher.close();
    _listExchangeCarOfUserFetcher.close();
    _exchangeCarDetailOfUserFetcher.close();
    _listUserExchangeResponseFetcher.close();
    _listUserExchangeToBuyFetcher.close();
    _listUserFeedbackFetcher.close();
  }
}

final exchangeBloc = ExchangeBloc();
