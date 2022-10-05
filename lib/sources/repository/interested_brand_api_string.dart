const String BASE_URL = "https://carworld.cosplane.asia";

class GetAllBrandApiString {
  //update profile
  // https://carworld.cosplane.asia/api/user/UpdateProfile?id=

  static String InterestedBrand() {
    return BASE_URL + '/api/brand/GetAllBrandsOfCar';
  }

  static String SubmitInterestedBrand() {
    return BASE_URL + '/api/user/ChooseInterestedBrand';
  }

  static String InterestedBrandByUserId(int userId) {
    return BASE_URL + '/api/user/GetUserInterestedBrands?userId=$userId';
  }
}
