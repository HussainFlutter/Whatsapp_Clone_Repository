part of 'get_my_status_cubit.dart';

abstract class GetMyStatusState extends Equatable {
  const GetMyStatusState();
}

class GetMyStatusInitial extends GetMyStatusState {
  @override
  List<Object> get props => [];
}
class GetMyStatusLoaded extends GetMyStatusState {
  final StatusEntity? status;

  const GetMyStatusLoaded({ this.status});
  @override
  List<Object> get props => [status!];
}
