part of 'user_bloc.dart';

class UserState extends Equatable {
  final List<User> users;

  const UserState({this.users = const <User>[]});

  @override
  List<Object?> get props => [users];
}
