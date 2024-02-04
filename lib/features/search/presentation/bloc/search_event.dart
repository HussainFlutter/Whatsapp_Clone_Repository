part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class FetchContactsEvent extends SearchEvent {
  final BuildContext context;

  const FetchContactsEvent({required this.context});
  @override
  List<Object?> get props => [context];

}
class CreateOrFetchChatRoomEvent  extends SearchEvent{
  final UserEntity currentUser;
  final UserEntity targetUser;
  final BuildContext context;
  const CreateOrFetchChatRoomEvent(this.context, {required this.currentUser, required this.targetUser});
  @override
  List<Object?> get props => [];
}