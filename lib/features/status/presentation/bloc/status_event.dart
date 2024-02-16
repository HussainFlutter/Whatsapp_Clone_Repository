part of 'status_bloc.dart';

abstract class StatusEvent extends Equatable {
  const StatusEvent();
  @override
  List<Object?> get props => [];
}

class CreateStatusEvent extends StatusEvent{
  final UserEntity? currentUser;

  const CreateStatusEvent({required this.currentUser});
  @override
  List<Object?> get props => [currentUser];
}
class DeleteStatusEvent extends StatusEvent{}
class UpdateStatusEvent extends StatusEvent{}
class GetStatusEvent extends StatusEvent{}
