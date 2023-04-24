import 'package:chat_app/api/firebase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/models/user.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<LoadUsers>(_onLoadUsers);
    on<LoadUser>(_onUser);
    on<LoadContacts>(_onLoadContacts);
    on<LoadRequests>(_onLoadRequests);
    on<ListenUser>(_onListenUser);
  }
  void _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    try {
      emit(UserState(
          contacts: state.contacts,
          requests: state.requests,
          users: event.users,
          search: state.search,
          userID: state.userID,
          user: state.user));
    } catch (e) {
      throw Exception(e);
    }
  }

  void _onUser(LoadUser event, Emitter<UserState> emit) async {
    try {
      var result = await FirebaseAPI.getUser(event.userID);
      emit(UserState(
          contacts: state.contacts,
          requests: state.requests,
          users: state.users,
          search: state.search,
          userID: event.userID,
          user: result));
    } catch (e) {
      throw Exception(e);
    }
  }

  void _onLoadContacts(LoadContacts event, Emitter<UserState> emit) async {
    emit(UserState(
        contacts: event.contacts,
        requests: state.requests,
        users: state.users,
        search: state.search,
        userID: state.userID,
        user: state.user));
  }

  void _onLoadRequests(LoadRequests event, Emitter<UserState> emit) {
    emit(UserState(
        contacts: state.contacts,
        requests: event.requests,
        users: state.users,
        search: state.search,
        userID: state.userID,
        user: state.user));
  }

  void _onListenUser(ListenUser event, Emitter<UserState> emit) {
    emit(UserState(
        contacts: state.contacts,
        requests: state.requests,
        users: state.users,
        search: state.search,
        userID: state.userID,
        user: event.user));
  }
}
