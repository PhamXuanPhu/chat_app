import 'package:chat_app/api/firebase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/models/user.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<LoadUsers>(_onLoadUsers);
  }
  void _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    try {
      var result = await FirebaseAPI.getUsers();
      if (result.isNotEmpty) {
        emit(UserState(users: result));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
