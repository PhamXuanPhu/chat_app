part of 'setting_bloc.dart';

class SettingState extends Equatable {
  final bool theme;
  final bool notification;
  final String language;

  const SettingState(
      {required this.theme,
      required this.notification,
      required this.language});

  @override
  List<Object> get props => [theme, notification, language];
}
