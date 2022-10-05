const String BASE_URL = "https://carworld.cosplane.asia";

class ContestApiString {
  //get all new contest
  //https://carworld.cosplane.asia/api/contestEvent/GetNewCEs?type=2&now=2021-10-20T00%3A38%3A36.100Z
  static String getAllContest(String now) {
    return BASE_URL + '/api/contestEvent/GetCEsMobile?type=2&now=$now';
  }

  static String getListContestByInterestedBrand(String now) {
    return BASE_URL +
        '/api/contestEvent/GetCEsByUserInterestedBrands?type=2&now=$now';
  }

  //get all significant contest
  //https://carworld.cosplane.asia/api/contestEvent/GetSignificantCEs?type=2&now=2021-10-20T00%3A38%3A36.100Z
  static String getAllContestByBrand(String now, String brandID) {
    return BASE_URL +
        '/api/contestEvent/GetCEsByBrandMobile?type=2&brandId=$brandID&now=$now';
  }

  //get contest detail
  static String getContestDetail(String id) {
    return BASE_URL + '/api/contestEvent/GetCEById?id=$id';
  }

  //user register contest
  // https://carworld.cosplane.asia/api/ceRegister/RegisterCE
  static String registerContest() {
    return BASE_URL + '/api/ceRegister/RegisterCE';
  }

  //user cancel contest
//https://carworld.cosplane.asia/api/userContest/CancelRegisterContest
  static String cancelContest() {
    return BASE_URL + '/api/ceRegister/CancelRegisterCE';
  }

  //get list contest of user register
  static String getListContestUserRegister(int id) {
    return BASE_URL + '/api/ceRegister/GetCEsRegistered?type=2&userId=$id';
  }

  //get list contest of user joined

  static String getListContestUserJoined(int id) {
    return BASE_URL + '/api/ceRegister/GetCEsJoined?type=2&userId=$id';
  }

  //user rating contest
  //https://carworld.cosplane.asia/api/userContest/EvaluateContest?evaluation=1
  static String ratingContest(double rate) {
    return BASE_URL + '/api/ceRegister/EvaluateCE?evaluation=$rate';
  }

  //user feedback contest
  //https://carworld.cosplane.asia/api/feedback/FeedbackContest?contestId=1
  static String feedbackContest(String id) {
    return BASE_URL + '/api/feedback/FeedbackCE?contestEventId=$id';
  }

  static String getContestPrize(String id) {
    return BASE_URL + '/api/contestPrize/GetPrizesByContestId?contestId=$id';
  }
}
