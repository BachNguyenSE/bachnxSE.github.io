const String BASE_URL = "https://carworld.cosplane.asia";

class AccessoryApiString {
  //get all accessory
  //https://carworld.cosplane.asia/api/accessory/GetAllAccessories
  static String getListAccessory() {
    return BASE_URL + '/api/accessory/GetAllAccessories';
  }

  //get list accessory by name
  //https://carworld.cosplane.asia/api/accessory/GetAccessoryByName?accessoryName=tes
  static String getListAccessoryByName(String name) {
    return BASE_URL + '/api/accessory/GetAccessoriesByName?accessoryName=$name';
  }

  //get list accessory by brand name
  //https://carworld.cosplane.asia/api/accessory/GetAccessoryByBrand?brandName=denso
  static String getListAccessoryByBrandName(String name) {
    return BASE_URL + '/api/accessory/GetAccessoryByBrand?brandName=$name';
  }

  //get accessory detail by id
  //https://carworld.cosplane.asia/api/accessory/GetAccessoryById?id=7
  static String getAccessoryDetail(String id) {
    return BASE_URL + '/api/accessory/GetAccessoryById?id=$id';
  }

  //get brand detail
  //https://carworld.cosplane.asia/api/brand/GetBrandById?id=1007
  static String getBrandDetail(String id) {
    return BASE_URL + '/api/brand/GetBrandById?id=$id';
  }

   static String getTitleExchangeByID(String id) {
    return BASE_URL + '/api/exchange/GetExchangeById?id=$id';
  }
}
