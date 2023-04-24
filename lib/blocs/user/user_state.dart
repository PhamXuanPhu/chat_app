part of 'user_bloc.dart';

class UserState extends Equatable {
  final List<User> users;
  final List<User> contacts;
  final List<User> requests;
  final User user;
  final String search;
  final String userID;

  const UserState(
      {this.users = const <User>[],
      this.contacts = const <User>[],
      this.requests = const <User>[],
      this.user = const User(),
      this.search = '',
      this.userID = ''});

  @override
  List<Object?> get props => [users, search, userID, user, contacts, requests];
}
