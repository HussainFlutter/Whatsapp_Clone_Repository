import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';
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
    on<FetchMessagesEvent>((event, emit) => _fetchMessages(event, emit));
    on<SendMessageEvent>((event, emit) => _sendMessage(event));
  }
  _fetchMessages(
    FetchMessagesEvent event,
    Emitter<ChatRoomState> emit,
  ) async {
    emit(ChatRoomLoading());
    try {
      Completer<void> completer = Completer<void>();
      List<MessageEntity> messages = [];
      getMessages(ChatRoomEntity(
        chatRoomId: event.chatRoomId,
      )).listen((event) {
        event.fold((message) {
          messages = message;
          //emit(ChatRoomLoaded(messages: messages));
          customPrint(message:"FIRST " + messages.toString());
          completer.complete();
        }, (r) {
          toast(message: r.message.toString());
        });
      },
     onDone:() => completer.complete(),
      onError:(e){
        toast(message: e.toString());
       completer.complete();
      },
      );
     await completer.future;
      customPrint(message: "SECOND " + messages.toString());
      emit(ChatRoomLoaded(messages: messages));
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
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
