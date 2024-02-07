import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
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
  ChatRoomBloc({
    required this.getMessages,
      required this.updateMessage,
      required this.sendMessage,
      required this.deleteMessage
      }) : super(ChatRoomInitial()) {
    on<SendMessageEvent>((event, emit) => _sendMessage(event));
  }
  _sendMessage (
      SendMessageEvent event,
      ) {
    try
    {
      sendMessage(MessageEntity(message:event.message,chatRoomId:event.chatRoomId,creatorUid:event.creatorUid));
    }catch(e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }
}
