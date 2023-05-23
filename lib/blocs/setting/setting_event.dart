part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SwitchThemeApp extends SettingEvent {
  final bool theme;
  const SwitchThemeApp({required this.theme});
  @override
  List<Object> get props => [theme];
}

class ChangeLanguage extends SettingEvent {
  final String languageCode;
  const ChangeLanguage({required this.languageCode});
  @override
  List<Object> get props => [languageCode];
}

class SwitchActiveStatus extends SettingEvent {
  final bool activeStatus;
  const SwitchActiveStatus({required this.activeStatus});
  @override
  List<Object> get props => [activeStatus];
}

class Init extends SettingEvent {
  final bool theme;
  final String languageCode;
  final bool activeStatus;

  const Init(
      {required this.theme,
      required this.languageCode,
      required this.activeStatus});
  @override
  List<Object> get props => [theme, languageCode, activeStatus];
}
