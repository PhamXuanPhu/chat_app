import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/data_service.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(const SettingState(
            theme: false, notification: true, language: '')) {
    on<SwitchThemeApp>(_onSwitchTheme);
    on<ChangeLanguage>(_onChangeLanguage);
  }
  void _onSwitchTheme(SwitchThemeApp event, Emitter<SettingState> emit) async {
    event.switchValue ? DataService.setMode(true) : DataService.setMode(false);
    emit(SettingState(
        theme: event.switchValue,
        notification: state.notification,
        language: state.language));
  }

  void _onChangeLanguage(
      ChangeLanguage event, Emitter<SettingState> emit) async {
    DataService.setLanguage(event.languageCode);
    emit(SettingState(
        theme: state.theme,
        notification: state.notification,
        language: event.languageCode));
  }
}
