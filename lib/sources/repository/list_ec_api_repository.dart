// ignore_for_file: camel_case_types

import 'package:car_world_system/sources/model/event_contest_now.dart';
import 'package:car_world_system/sources/repository/list_ec_api_provider.dart';

class getListECRepository {
  getListECApiProvider getListEC = getListECApiProvider();
  Future<List<eventContestNow>?> getListECNow(int type, String now) {
    return getListEC.getListECProvider(type, now);
  }
}
