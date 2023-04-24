import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/data_service.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState(theme: false)) {
    on<SwitchThemeApp>(_onSwitchTheme);
    on<ReloadLanguage>((event, emit) {});
  }
  void _onSwitchTheme(SwitchThemeApp event, Emitter<SettingState> emit) async {
    event.switchValue ? DataService.setMode(true) : DataService.setMode(false);
    emit(SettingState(theme: event.switchValue));
  }
}
