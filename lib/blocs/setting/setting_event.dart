part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SwitchThemeApp extends SettingEvent {
  final bool switchValue;
  const SwitchThemeApp({required this.switchValue});
  @override
  List<Object> get props => [switchValue];
}

class ChangeLanguage extends SettingEvent {
  final String languageCode;
  const ChangeLanguage({required this.languageCode});
  @override
  List<Object> get props => [languageCode];
}
