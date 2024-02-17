part of 'status_bloc.dart';

abstract class StatusEvent extends Equatable {
  const StatusEvent();
  @override
  List<Object?> get props => [];
}

class CreateStatusEvent extends StatusEvent{
  final UserEntity? currentUser;
  final BuildContext context;
  const CreateStatusEvent({required this.currentUser,required this.context});
  @override
  List<Object?> get props => [currentUser,context];
}
class DeleteStatusEvent extends StatusEvent{}
class UpdateStatusEvent extends StatusEvent{}
class GetStatusEvent extends StatusEvent{
  final UserEntity currentUser;

  const GetStatusEvent({required this.currentUser});
  @override
  List<Object?> get props => [currentUser];
}
class DemoEvent extends StatusEvent{
  final List<StatusEntity>? statusList;

  const DemoEvent({required this.statusList});
  @override
  List<Object?> get props => [statusList];
}