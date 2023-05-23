// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api/firebase.dart';
import '../../services/data_service.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(const SettingState(
            theme: false,
            notification: true,
            language: 'vi-VN',
            activeStatus: true)) {
    on<Init>(_onInit);
    on<SwitchThemeApp>(_onSwitchTheme);
    on<ChangeLanguage>(_onChangeLanguage);
    on<SwitchActiveStatus>(_onSwitchActiveStatus);
  }
  void _onInit(Init event, Emitter<SettingState> emit) async {
    emit(SettingState(
        theme: event.theme,
        notification: state.notification,
        language: event.languageCode,
        activeStatus: event.activeStatus));
  }

  void _onSwitchTheme(SwitchThemeApp event, Emitter<SettingState> emit) async {
    await FirebaseAPI.updateMode(event.theme);
    emit(SettingState(
        theme: event.theme,
        notification: state.notification,
        language: state.language,
        activeStatus: state.activeStatus));
  }

  void _onChangeLanguage(
      ChangeLanguage event, Emitter<SettingState> emit) async {
    await FirebaseAPI.updateLanguage(event.languageCode);
    emit(SettingState(
        theme: state.theme,
        notification: state.notification,
        language: event.languageCode,
        activeStatus: state.activeStatus));
  }

  void _onSwitchActiveStatus(
      SwitchActiveStatus event, Emitter<SettingState> emit) async {
    await FirebaseAPI.updateActiveStatus(event.activeStatus);
    FirebaseAPI.updateStateUser(event.activeStatus);
    emit(SettingState(
        theme: state.theme,
        notification: state.notification,
        language: state.language,
        activeStatus: event.activeStatus));
  }
}
