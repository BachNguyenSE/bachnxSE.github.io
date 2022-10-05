import 'package:car_world_system/sources/model/cancel_register_contest.dart';
import 'package:car_world_system/sources/model/cancel_register_event_contest.dart';
import 'package:car_world_system/sources/model/contest.dart';
import 'package:car_world_system/sources/model/contest_register.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/model/feedback.dart';
import 'package:car_world_system/sources/model/prize.dart';
import 'package:car_world_system/sources/model/userContest.dart';
import 'package:car_world_system/sources/model/user_event_contest.dart';
import 'package:car_world_system/sources/repository/contest_api_provider.dart';

class ContestRepository {
  ContestApiProvider contestApiProvider = ContestApiProvider();

  //get list all contest
  Future<List<EventContest>> getAllContest(String now) {
    return contestApiProvider.getAllContest(now);
  }

  // get list contest by interest brand
  Future<List<EventContest>> getListContestByInterestedBrand(
      String now, listBrand) {
    return contestApiProvider.getListContestByInterestedBrand(now, listBrand);
  }

  //get list significant contest
  Future<List<EventContest>> getAllContestbyBrand(String now, String brandID) {
    return contestApiProvider.getAllContestByBrand(now, brandID);
  }

  //get contest detail by id
  Future<EventContest> getContestDetail(String id) {
    return contestApiProvider.getContestDetail(id);
  }

  //register contest
  Future<bool> registerContest(UserEventContest userContest) {
    return contestApiProvider.registerContest(userContest);
  }

  //rating contest
  Future<bool> ratingContest(double rate, UserEventContest userContest) {
    return contestApiProvider.ratingContest(rate, userContest);
  }

  //feedback contest
  Future<bool> feedbackContest(String id, FeedBack feedback) {
    return contestApiProvider.feedbackContest(id, feedback);
  }

  //cancel contest
  Future<bool> cancelContest(CancelRegisterContestEvent userContest) {
    return contestApiProvider.cancelContest(userContest);
  }

  //get list contest user register
  Future<List<ContestRegister>> getListContestUserRegister(int id) {
    return contestApiProvider.getListContestUserRegister(id);
  }

  //get list contest user joined
  Future<List<ContestRegister>> getListContestUserJoined(int id) {
    return contestApiProvider.getListContestUserJoined(id);
  }

  Future<List<UserPrize>> getContestPrize(String id) {
    return contestApiProvider.getContestPrize(id);
  }
}
