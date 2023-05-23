part of 'user_bloc.dart';

// class UserState extends Equatable {
//   final List<User> users;
//   final List<User> contacts;
//   final List<User> requests;
//   final User user;
//   final User currentUser;

//   const UserState({
//     required this.users,
//     required this.contacts,
//     required this.requests,
//     required this.user,
//     required this.currentUser,
//   });

//   @override
//   List<Object?> get props => [users, currentUser, user, contacts, requests];
// }

class UserState extends Equatable {
  final List<User> users;
  final List<User> contacts;
  final List<User> requests;
  final User user;
  final User currentUser;

  const UserState({
    required this.users,
    required this.contacts,
    required this.requests,
    required this.user,
    required this.currentUser,
  });

  @override
  List<Object?> get props => [users, currentUser, user, contacts, requests];
}

class UserLoading extends UserState {
  const UserLoading(
      {required super.users,
      required super.contacts,
      required super.requests,
      required super.user,
      required super.currentUser});
}

class UserLoaded extends UserState {
  const UserLoaded(
      {required super.users,
      required super.contacts,
      required super.requests,
      required super.user,
      required super.currentUser});
}

class UserError extends UserState {
  final String message;
  const UserError(
      {required this.message,
      required super.users,
      required super.contacts,
      required super.requests,
      required super.user,
      required super.currentUser});
  @override
  List<Object?> get props => [message];
}
