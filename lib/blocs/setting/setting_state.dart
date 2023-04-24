part of 'setting_bloc.dart';

class SettingState extends Equatable {
  final bool theme;

  const SettingState({required this.theme});

  @override
  List<Object> get props => [theme];
}
