import 'package:car_world_system/sources/model/contest.dart';
import 'package:car_world_system/sources/model/contest_register.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/model/prize.dart';
import 'package:car_world_system/sources/repository/contest_repository.dart';
import 'package:rxdart/rxdart.dart';

class ContestBloc {
  final ContestRepository contestRepository = ContestRepository();

  final _listContestFetcher = PublishSubject<List<EventContest>>();
  final _contestDetailFetcher = PublishSubject<EventContest>();
  final _listContestRegisterFetcher = PublishSubject<List<ContestRegister>>();

  Observable<List<ContestRegister>> get listContestRegister =>
      _listContestRegisterFetcher.stream;
  Observable<List<EventContest>> get listContest => _listContestFetcher.stream;
  Observable<EventContest> get contestDetail => _contestDetailFetcher.stream;
  //get list new contest
  getAllContest(String now) async {
    List<EventContest> listContest = await contestRepository.getAllContest(now);
    _listContestFetcher.sink.add(listContest);
  }

  //get contest by interest brand
  getListContestByInterestedBrand(String now, List<String> listBrand) async {
    List<EventContest> listEvent =
        await contestRepository.getListContestByInterestedBrand(now, listBrand);
    _listContestFetcher.sink.add(listEvent);
  }

  //get list significant contest
  getAllContestByBrand(String now, String brandID) async {
    List<EventContest> listContest =
        await contestRepository.getAllContestbyBrand(now, brandID);
    _listContestFetcher.sink.add(listContest);
  }

  //get list contest user register
  getListContestUserRegister(int id) async {
    List<ContestRegister> listContestRegister =
        await contestRepository.getListContestUserRegister(id);
    _listContestRegisterFetcher.sink.add(listContestRegister);
  }

  //get list contest user joined
  getListContestUserJoined(int id) async {
    List<ContestRegister> listContestRegister =
        await contestRepository.getListContestUserJoined(id);
    _listContestRegisterFetcher.sink.add(listContestRegister);
  }

  //get contest detail by id
  getContestDetail(String id) async {
    EventContest contestDetail = await contestRepository.getContestDetail(id);
    _contestDetailFetcher.sink.add(contestDetail);
  }

  final _listContestPrizeFetcher = PublishSubject<List<UserPrize>>();

  Observable<List<UserPrize>> get listContestPrize =>
      _listContestPrizeFetcher.stream;

  getContestPrize(String id) async {
    List<UserPrize> listContest = await contestRepository.getContestPrize(id);
    _listContestPrizeFetcher.sink.add(listContest);
  }

  dispose() {
    _listContestPrizeFetcher.close();
    _listContestFetcher.close();
    _contestDetailFetcher.close();
    _listContestRegisterFetcher.close();
  }
}

final contestBloc = ContestBloc();
