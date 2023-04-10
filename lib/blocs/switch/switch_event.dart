part of 'switch_bloc.dart';

class SwitchEvent extends Equatable {
  final bool switchValue;
  const SwitchEvent({required this.switchValue});

  @override
  List<Object> get props => [switchValue];
}
