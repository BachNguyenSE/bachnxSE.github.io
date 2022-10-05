const String BASE_URL = "https://carworld.cosplane.asia";

class EventApiString {
  //get all new event
  static String getAllEvent(String now) {
    return BASE_URL + '/api/contestEvent/GetCEsMobile?type=1&now=$now';
  }

  static String getListEventByInterestedBrand(String now) {
    return BASE_URL +
        '/api/contestEvent/GetCEsByUserInterestedBrands?type=1&now=$now';
  }

  //get all signnificant event
  static String getAllEventByBrand(String now, String brandID) {
    return BASE_URL +
        '/api/contestEvent/GetCEsByBrandMobile?type=1&brandId=$brandID&now=$now';
  }

  //get event detail
  //https://carworld.cosplane.asia/api/contestEvent/GetCEById?id=265b78c9-213d-4038-8d88-217e10363bf6
  static String getEventDetail(String id) {
    return BASE_URL + '/api/contestEvent/GetCEById?id=$id';
  }

  // create proposal
  //https://carworld.cosplane.asia/api/proposal/CreateNewProposal
  static String createProposal() {
    return BASE_URL + '/api/proposal/CreateNewProposal';
  }

  //user register event

  static String registerEvent() {
    return BASE_URL + '/api/ceRegister/RegisterCE';
  }

  //user cancel event

  static String cancelEvent() {
    return BASE_URL + '/api/ceRegister/CancelRegisterCE';
  }

  //get list proposal of user send for manager
  //https://carworld.cosplane.asia/api/proposal/GetProposalsUserSubmited?userId=18
  static String getListProposalOfUser(int id) {
    return BASE_URL + '/api/proposal/GetProposalsUserSubmited?userId=$id';
  }

  //get list event of user register
  static String getListEventUserRegister(int id) {
    return BASE_URL + '/api/ceRegister/GetCEsRegistered?type=1&userId=$id';
  }

  //get list event of user joined

  static String getListEventUserJoined(int id) {
    return BASE_URL + '/api/ceRegister/GetCEsJoined?type=1&userId=$id';
  }

  //get proposal detail
  //https://carworld.cosplane.asia/api/proposal/GetProposalById?id=7

  static String getProposalDetail(String id) {
    return BASE_URL + '/api/proposal/GetProposalById?id=$id';
  }

  //user rating event
  //https://carworld.cosplane.asia/api/userEvent/EvaluateEvent?evaluation=4
  static String ratingEvent(double rate) {
    return BASE_URL + '/api/ceRegister/EvaluateCE?evaluation=$rate';
  }

  //user feedback event
  //https://carworld.cosplane.asia/api/feedback/FeedbackEvent?eventId=1
  static String feedbackEvent(String id) {
    return BASE_URL + '/api/feedback/FeedbackCE?contestEventId=$id';
  }
}
