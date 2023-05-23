part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {
  final List<User> users;
  const LoadUsers({required this.users});
  @override
  List<Object> get props => [users];
}

class LoadUser extends UserEvent {
  final String userID;
  const LoadUser({required this.userID});
  @override
  List<Object> get props => [userID];
}

class LoadContacts extends UserEvent {
  final List<User> contacts;
  const LoadContacts({required this.contacts});
  @override
  List<Object> get props => [contacts];
}

class LoadRequests extends UserEvent {
  final List<User> requests;
  const LoadRequests({required this.requests});
  @override
  List<Object> get props => [requests];
}

class LoadCurrentUser extends UserEvent {
  const LoadCurrentUser();
  @override
  List<Object> get props => [];
}

class UpdateCurrentUser extends UserEvent {
  final User newData;
  const UpdateCurrentUser({required this.newData});
  @override
  List<Object> get props => [newData];
}
