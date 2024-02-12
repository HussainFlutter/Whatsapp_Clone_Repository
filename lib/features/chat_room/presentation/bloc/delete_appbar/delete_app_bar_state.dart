part of 'delete_app_bar_cubit.dart';


class DeleteAppBarState  extends Equatable{
  final bool selected;
   final List<int> selectedIndex;
   final List<String> messagesIds;
   final int messagesSelected;
   const DeleteAppBarState({required this.selected, this.selectedIndex = const [],required this.messagesSelected,this.messagesIds = const [] });
  @override
  List<Object> get props => [selected,selectedIndex];
}
