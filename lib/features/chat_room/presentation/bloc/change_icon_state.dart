part of 'change_icon_cubit.dart';

abstract class ChangeIconState extends Equatable {
  const ChangeIconState();
}

class ChangeIconInitial extends ChangeIconState {
  @override
  List<Object> get props => [];
}
class ChangedIcon extends ChangeIconState {
  final bool change;
  const ChangedIcon({required this.change});
  @override
  List<Object> get props => [change];
}
