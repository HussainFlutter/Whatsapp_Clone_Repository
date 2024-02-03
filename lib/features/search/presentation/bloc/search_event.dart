part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class FetchContactsEvent extends SearchEvent {
  final BuildContext context;

  const FetchContactsEvent({required this.context});
  @override
  List<Object?> get props => [context];

}
//TODO: make a event for createChatRoom function