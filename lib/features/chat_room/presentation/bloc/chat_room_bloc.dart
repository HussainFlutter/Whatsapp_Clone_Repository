import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/usecase/change_message_seen_status_use_case.dart';
import '../../domain/usecase/delete_message_use_case.dart';
import '../../domain/usecase/get_messages_use_case.dart';
import '../../domain/usecase/send_message_use_case.dart';
import '../../domain/usecase/update_message_use_case.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final GetMessagesUseCase getMessages;
  final SendMessageUseCase sendMessage;
  final DeleteMessageUseCase deleteMessage;
  final UpdateMessageUseCase updateMessage;
  final ChangeMessageSeenStatusUseCase changeStatus;
  ChatRoomBloc({
      required this.getMessages,
      required this.updateMessage,
      required this.sendMessage,
      required this.deleteMessage,
      required this.changeStatus,
  })
      : super(ChatRoomInitial()) {
    on<SendMessageEvent>((event, emit) => _sendMessage(event));
    on<ChangeIsSeenEvent>((event, emit) => _changeSeenStatus (event));
    on<DeleteMessageEvent>((event, emit) => _deleteMessage(event));
  }
  _sendMessage(
    SendMessageEvent event,
  ) {
    try {
      sendMessage(MessageEntity(
          message: event.message,
          chatRoomId: event.chatRoomId,
          creatorUid: event.creatorUid,
          targetUserUid: event.targetUserUid));
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }
  _changeSeenStatus (
      ChangeIsSeenEvent event,
      ) async{
    await changeStatus(event.messageEntity);
  }
  _deleteMessage(
      DeleteMessageEvent event,
      ) async {
    await deleteMessage(MessageEntity(chatRoomId: event.chatroomId,messageId:event.messageId ));
  }
}
