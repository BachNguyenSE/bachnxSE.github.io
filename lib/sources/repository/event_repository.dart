import 'package:car_world_system/sources/model/cancel_register_event.dart';
import 'package:car_world_system/sources/model/cancel_register_event_contest.dart';
import 'package:car_world_system/sources/model/event.dart';
import 'package:car_world_system/sources/model/event_contest.dart';
import 'package:car_world_system/sources/model/event_register.dart';
import 'package:car_world_system/sources/model/feedback.dart';
import 'package:car_world_system/sources/model/listProposal.dart';
import 'package:car_world_system/sources/model/proposal.dart';
import 'package:car_world_system/sources/model/proposal_detail.dart';
import 'package:car_world_system/sources/model/userEvent.dart';
import 'package:car_world_system/sources/model/user_event_contest.dart';
import 'package:car_world_system/sources/repository/event_api_provider.dart';
import 'package:flutter/material.dart';

class EventRepository {
  EventApiProvider eventApiProvider = EventApiProvider();

  //get list new event
  Future<List<EventContest>> getAllEvent(String now) {
    return eventApiProvider.getAllEvent(now);
  }

  Future<List<EventContest>> getListEventByInterestedBrand(
      String now, listBrand) {
    return eventApiProvider.getListEventByInterestedBrand(now, listBrand);
  }

  //get list significant event
  Future<List<EventContest>> getAllEventByBrand(String now, String brandID) {
    return eventApiProvider.getAllEventByBrand(now, brandID);
  }

  //get event detail by id
  Future<EventContest> getEventDetail(String id) {
    return eventApiProvider.getEventDetail(id);
  }

  //create proposal
  Future<bool> createProposal(Proposal proposal) {
    return eventApiProvider.createProposal(proposal);
  }

  //register event
  Future<bool> registerEvent(UserEventContest userEvent) {
    return eventApiProvider.registerEvent(userEvent);
  }

  //rating event
  Future<bool> ratingEvent(double rate, UserEventContest userEvent) {
    return eventApiProvider.ratingEvent(rate, userEvent);
  }

  //feedback event
  Future<bool> feedbackEvent(String id, FeedBack feedback) {
    return eventApiProvider.feedbackEvent(id, feedback);
  }

  //cancel event
  Future<bool> cancelEvent(CancelRegisterContestEvent userEvent) {
    return eventApiProvider.cancelEvent(userEvent);
  }

  //get list proposal of user
  Future<List<ListProposal>> getListProposalOfUser(int id) {
    return eventApiProvider.getListProposalOfUser(id);
  }

  //get list event user register
  Future<List<EventRegister>> getListEventUserRegister(int id) {
    return eventApiProvider.getListEventUserRegister(id);
  }

  //get list event user joined
  Future<List<EventRegister>> getListEventUserJoined(int id) {
    return eventApiProvider.getListEventUserJoined(id);
  }

  //get proposal detail by id
  Future<ProposalDetail> getProposalDetail(String id) {
    return eventApiProvider.getProposalDetail(id);
  }
}
