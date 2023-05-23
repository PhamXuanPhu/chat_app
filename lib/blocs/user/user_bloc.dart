import 'package:chat_app/api/firebase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/models/user.dart';

import '../../configs/config.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc()
      : super(UserState(
            users: List.empty(),
            requests: List.empty(),
            contacts: List.empty(),
            user: User(),
            currentUser: User())) {
    on<LoadUsers>(_onLoadUsers);
    on<LoadUser>(_onUser);
    on<LoadContacts>(_onLoadContacts);
    on<LoadRequests>(_onLoadRequests);
    on<LoadCurrentUser>(_onLoadCurrentUser);
    on<UpdateCurrentUser>(_onUpdateCurrentUser);
  }
  void _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    try {
      emit(UserLoaded(
          contacts: state.contacts,
          requests: state.requests,
          users: event.users,
          currentUser: state.currentUser,
          user: state.user));
    } catch (e) {
      throw Exception(e);
    }
  }

  void _onUser(LoadUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading(
          contacts: state.contacts,
          requests: state.requests,
          users: state.users,
          currentUser: state.currentUser,
          user: state.user));
      var result = await FirebaseAPI.getUser(event.userID);
      if (result.id.isNotEmpty) {
        emit(UserLoaded(
            contacts: state.contacts,
            requests: state.requests,
            users: state.users,
            currentUser: state.currentUser,
            user: result));
      } else {
        emit(UserError(
            contacts: state.contacts,
            requests: state.requests,
            users: state.users,
            currentUser: result,
            user: state.user,
            message: 'Error'));
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void _onLoadContacts(LoadContacts event, Emitter<UserState> emit) async {
    emit(UserLoaded(
        contacts: event.contacts,
        requests: state.requests,
        users: state.users,
        currentUser: state.currentUser,
        user: state.user));
  }

  void _onLoadRequests(LoadRequests event, Emitter<UserState> emit) {
    emit(UserLoaded(
        contacts: state.contacts,
        requests: event.requests,
        users: state.users,
        currentUser: state.currentUser,
        user: state.user));
  }

  void _onLoadCurrentUser(
      LoadCurrentUser event, Emitter<UserState> emit) async {
    emit(UserLoading(
        contacts: state.contacts,
        requests: state.requests,
        users: state.users,
        currentUser: state.currentUser,
        user: state.user));
    var result = await FirebaseAPI.getUser(Config.user.id);
    if (result.id.isNotEmpty) {
      emit(UserLoaded(
          contacts: state.contacts,
          requests: state.requests,
          users: state.users,
          currentUser: result,
          user: state.user));
    } else {
      emit(UserError(
          contacts: state.contacts,
          requests: state.requests,
          users: state.users,
          currentUser: result,
          user: state.user,
          message: 'Error'));
    }
  }

  void _onUpdateCurrentUser(
      UpdateCurrentUser event, Emitter<UserState> emit) async {
    emit(UserLoading(
        contacts: state.contacts,
        requests: state.requests,
        users: state.users,
        currentUser: state.currentUser,
        user: state.user));
    var result = await FirebaseAPI.updateUserInformation(event.newData);
    if (result) {
      Config.user = event.newData;
      emit(UserLoaded(
          contacts: state.contacts,
          requests: state.requests,
          users: state.users,
          currentUser: event.newData,
          user: state.user));
    } else {
      emit(UserError(
          contacts: state.contacts,
          requests: state.requests,
          users: state.users,
          currentUser: state.currentUser,
          user: state.user,
          message: 'Error'));
    }
  }
}
