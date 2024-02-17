part of 'status_bloc.dart';

abstract class StatusState extends Equatable {
  const StatusState();
  @override
  List<Object> get props => [];
}

class StatusInitial extends StatusState {}
class StatusLoadingState extends StatusState {}
class StatusLoadedState extends StatusState{
  final List<StatusEntity>? statusList;

  const StatusLoadedState({required this.statusList});
  @override
  List<Object> get props => [];
}
class StatusErrorState extends StatusState{}
