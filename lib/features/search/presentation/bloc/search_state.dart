part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchLoaded extends SearchState {
  final List<UserEntity> foundUsers;
  final List<Contact> notFoundUsers;

  const SearchLoaded({required this.foundUsers,required this.notFoundUsers});
  @override
  List<Object> get props => [foundUsers,notFoundUsers];
}
class SearchError extends SearchState {}