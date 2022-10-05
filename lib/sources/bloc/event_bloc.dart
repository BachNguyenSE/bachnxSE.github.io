import 'package:car_world_system/sources/model/event.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/model/event_register.dart';
import 'package:car_world_system/sources/model/listProposal.dart';
import 'package:car_world_system/sources/model/proposal_detail.dart';
import 'package:car_world_system/sources/repository/event_repository.dart';
import 'package:rxdart/rxdart.dart';

class EventBloc {
  final EventRepository eventRepository = EventRepository();

  final _listEventFetcher = PublishSubject<List<EventContest>>();
  final _listEventRegisterFetcher = PublishSubject<List<EventRegister>>();
  final _listProposalOfUserFetcher = PublishSubject<List<ListProposal>>();
  final _eventDetailFetcher = PublishSubject<EventContest>();
  final _proposalDetailFetcher = PublishSubject<ProposalDetail>();

  Observable<List<EventContest>> get listEvent => _listEventFetcher.stream;
  Observable<List<EventRegister>> get listEventRegister =>
      _listEventRegisterFetcher.stream;
  Observable<List<ListProposal>> get listProposalOfUser =>
      _listProposalOfUserFetcher.stream;
  Observable<EventContest> get eventDetail => _eventDetailFetcher.stream;
  Observable<ProposalDetail> get proposalDetail =>
      _proposalDetailFetcher.stream;
  //get list new event
  getAllEvent(String now) async {
    List<EventContest> listEvent = await eventRepository.getAllEvent(now);
    _listEventFetcher.sink.add(listEvent);
  }

  getListEventByInterestedBrand(String now, List<String> listBrand) async {
    List<EventContest> listEvent =
        await eventRepository.getListEventByInterestedBrand(now, listBrand);
    _listEventFetcher.sink.add(listEvent);
  }

  //get list significant event
  getAllEventByBrand(String now, String brandID) async {
    List<EventContest> listEvent =
        await eventRepository.getAllEventByBrand(now, brandID);
    _listEventFetcher.sink.add(listEvent);
  }

  //get list proposal of user
  getListProposalOfUser(int id) async {
    List<ListProposal> listProposal =
        await eventRepository.getListProposalOfUser(id);
    _listProposalOfUserFetcher.sink.add(listProposal);
  }

  //get list event user register
  getListEventUserRegister(int id) async {
    List<EventRegister> listEventRegister =
        await eventRepository.getListEventUserRegister(id);
    _listEventRegisterFetcher.sink.add(listEventRegister);
  }

  //get list event user joined
  getListEventUserJoined(int id) async {
    List<EventRegister> listEventRegister =
        await eventRepository.getListEventUserJoined(id);
    _listEventRegisterFetcher.sink.add(listEventRegister);
  }

  //get event detail by id
  getEventDetail(String id) async {
    EventContest eventDetail = await eventRepository.getEventDetail(id);
    _eventDetailFetcher.sink.add(eventDetail);
  }

  //get proposal detail by id
  getProposalDetail(String id) async {
    ProposalDetail proposalDetail = await eventRepository.getProposalDetail(id);
    _proposalDetailFetcher.sink.add(proposalDetail);
  }

  dispose() {
    _listEventFetcher.close();
    _listEventRegisterFetcher.close();
    _eventDetailFetcher.close();
    _listProposalOfUserFetcher.close();
    _proposalDetailFetcher.close();
  }
}

final eventBloc = EventBloc();
