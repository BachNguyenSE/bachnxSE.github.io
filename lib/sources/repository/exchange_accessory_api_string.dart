const String BASE_URL = "https://carworld.cosplane.asia";

class ExchangeAccessoryApiString {
//create exchange accessory
  static String createExchangeAccessory() {
    return BASE_URL + '/api/exchange/CreateAccessoryExchange';
  }

  //get all exchange accessory by user id
  static String getAllExchangeAccessoryByUserID(int id) {
    return BASE_URL + '/api/exchange/GetInProcessExchanges?type=2&userId=$id';
  }

  //get detail exchange accessory of user for manager
  static String getDetailExchangeAccessory(String id) {
    return BASE_URL + '/api/exchange/GetExchangeById?id=$id';
  }

  //user cancel exchange accessory
  static String cancelExchangeAccessory(String id) {
    return BASE_URL + '/api/exchange/CancelExchange?id=$id';
  }

//create exchange car
//https://carworld.cosplane.asia/api/exchangeCar/CreateExchangeCar
  static String createExchangeCar() {
    return BASE_URL + '/api/exchange/CreateCarExchange';
  }

  //get all exchange car by user id
  //https://carworld.cosplane.asia/api/exchangeCar/GetAllExchanges?userId=1
  static String getAllExchangeCarByUserID(int id) {
    return BASE_URL + '/api/exchange/GetInProcessExchanges?type=1&userId=$id';
  }

  //get detail exchange car of user for manager
  //https://carworld.cosplane.asia/api/exchangeCar/GetExchangeById?id=2edvvvvvvvvvvvvv
  static String getDetailExchangeCar(String id) {
    return BASE_URL + '/api/exchange/GetExchangeById?id=$id';
  }

  //user cancel exchange car
  //https://carworld.cosplane.asia/api/exchangeCar/CancelExchange?id=ddddd
  static String cancelExchangeCar(String id) {
    return BASE_URL + '/api/exchange/CancelExchange?id=$id';
  }

  //send exchange response car
  static String sendExchangeResponeseCarAndAccessory() {
    return BASE_URL + "/api/exchangeResponse/SendExResponse";
  }

  //get list user want to exchange
  static String getListUserWanttoExchange(String id) {
    return BASE_URL + "/api/exchangeResponse/GetExResponses?exchangeId=$id";
  }

  // list exchange by location
  //get list exchange car by location filter
  static String getAllExchangeCarByLocation(int id) {
    return BASE_URL + "/api/exchange/GetAllExchanges?type=1&userId=$id";
  }

  //get list exchange accessory by location filter
  static String getAllExchangeAccessoryByLocation(int id) {
    return BASE_URL + "/api/exchange/GetAllExchanges?type=2&userId=$id";
  }

  static String getAllExchangeAccessoryByProvince(String provinceID, int id) {
    return BASE_URL +
        "/api/exchange/GetExchangesInCity?type=2&userId=$id&cityId=$provinceID";
  }

  static String getAllExchangeAccessoryByProvinceAndDistrict(
      String provinceID, String districtID, int id) {
    return BASE_URL +
        "/api/exchange/GetExchangesInDistrict?type=2&userId=$id&cityId=$provinceID&districtId=$districtID";
  }

  static String getAllExchangeCarByProvince(String provinceID, int id) {
    return BASE_URL +
        "/api/exchange/GetExchangesInCity?type=1&userId=$id&cityId=$provinceID";
  }

  static String getAllExchangeCarByProvinceAndDistrict(
      String provinceID, String districtID, int id) {
    return BASE_URL +
        "/api/exchange/GetExchangesInDistrict?type=1&userId=$id&cityId=$provinceID&districtId=$districtID";
  }

  static String acceptExchange(String exchangeID, int userID) {
    return BASE_URL +
        '/api/exchangeResponse/AcceptExResponse?exchangeId=$exchangeID&userId=$userID';
  }

  //lay nhung xe da ban
  //https://carworld.cosplane.asia/api/exchange/GetFinishedExchanges?type=1&userId=20
  static String getExchangeCarToSell(int userID) {
    return BASE_URL +
        '/api/exchange/GetFinishedExchanges?type=1&userId=$userID';
  }

  //lay nhung linh kien da ban
  //https://carworld.cosplane.asia/api/exchange/GetFinishedExchanges?type=2&userId=20
  static String getExchangeAccessoryToSell(int userID) {
    return BASE_URL +
        '/api/exchange/GetFinishedExchanges?type=2&userId=$userID';
  }

  // gui phan hoi ve sp da ban
  //https://carworld.cosplane.asia/api/feedback/FeedbackExchange?exchangeId=aaaa
  static String sendFeedBackExchangeToSell(String exchangeID) {
    return BASE_URL + '/api/feedback/FeedbackExchange?exchangeId=$exchangeID';
  }

  //lay sp da mua
  //https://carworld.cosplane.asia/api/exchangeResponse/GetAcceptedResponses?userId=19
  static String getExchangeToBuy(int userID) {
    return BASE_URL +
        '/api/exchangeResponse/GetAcceptedResponses?userId=$userID';
  }

  // gui phan hoi ve sp da mua
  //https://carworld.cosplane.asia/api/feedback/FeedbackExResponse?exResId=asa
  static String sendFeedBackExchangeToBuy(String exchangeID) {
    return BASE_URL + '/api/feedback/FeedbackExResponse?exResId=$exchangeID';
  }


   static String getListUserFeedback(int id) {
    return BASE_URL + '/api/feedback/GetUserFeedbacks?userId=$id';
  }


  static String getBuyerAndSellerInfo(int id) {
    return BASE_URL + '/api/user/GetUserById?id=$id';
  } 

}
