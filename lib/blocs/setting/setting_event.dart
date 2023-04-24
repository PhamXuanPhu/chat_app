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

class ReloadLanguage extends SettingEvent {
  const ReloadLanguage();
  @override
  List<Object> get props => [];
}
