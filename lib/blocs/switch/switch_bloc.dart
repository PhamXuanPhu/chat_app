import 'package:bloc/bloc.dart';
import 'package:chat_app/services/data_service.dart';
import 'package:equatable/equatable.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchState(false)) {
    on<SwitchEvent>((event, emit) {
      event.switchValue
          ? DataService.setMode(true)
          : DataService.setMode(false);
      emit(SwitchState(event.switchValue));
    });
  }
}
