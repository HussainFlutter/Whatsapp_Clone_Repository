
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chat_room_bloc.dart';

part 'delete_app_bar_state.dart';

class DeleteAppBarCubit extends Cubit<DeleteAppBarState> {
  DeleteAppBarCubit() : super( const DeleteAppBarState(selected: false,selectedIndex:  [],messagesSelected: 0));
  void changeSelected ({required bool selected, int? index , bool? remove , bool? clear,String? messageId}) {

    List<int> list = List.from(state.selectedIndex);
    List<String> messageIds = List.from(state.messagesIds);
    if(clear == true)
      {
        list.clear();
        messageIds.clear();
      }
    if(index == null && messageId == null)
      {

      }
    else if (remove == true)
      {
        list.remove(index);
        messageIds.remove(messageId);
      }
    else
    {
      print("adding");
      list.add(index!);
      messageIds.add(messageId!);
    }
    print(list);
    print(messageIds);
    emit(DeleteAppBarState(selected: selected,selectedIndex: list,messagesSelected: list.length,messagesIds: messageIds));
  }
  void deleteMessages (BuildContext context,String chatRoomId){
    print("deleting2");
    print(state.messagesIds);
    for (int i = 0 ; i<state.messagesIds.length;i++)
      {
        print("deleting");
        context.read<ChatRoomBloc>().add(
            DeleteMessageEvent(
              messageId: state.messagesIds[i],
              chatroomId: chatRoomId,
            ));
      }
    emit(const DeleteAppBarState(selected: false, messagesSelected: 0));
  }
}
