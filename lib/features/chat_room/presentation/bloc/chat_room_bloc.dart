
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/usecase/change_message_seen_status_use_case.dart';
import '../../domain/usecase/delete_message_use_case.dart';
import '../../domain/usecase/get_messages_use_case.dart';
import '../../domain/usecase/send_message_use_case.dart';
import '../../domain/usecase/update_message_use_case.dart';
import 'package:path/path.dart' as path;

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
    on<SendVideoOrImage>((event, emit) => _sendVideoOrImage(event));
  }
  _sendMessage(
    SendMessageEvent event,
  ) {
    try {
      sendMessage(MessageEntity(
          messageType: MessageType.text,
          name: event.name,
          message: event.message,
          chatRoomId: event.chatRoomId,
          creatorUid: event.creatorUid,
          targetUserUid: event.targetUserUid,
          replyMessage: event.replyMessage,
      ));
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }


  _sendVideoOrImage(
      SendVideoOrImage event,
      ) async {
    try {
      ImagePicker picker = ImagePicker();
      List<XFile>? pickedFiles = await picker.pickMultipleMedia();
      if (pickedFiles.isNotEmpty) {
        for (int i = 0; i < pickedFiles.length; i++) {
          String extension = path.extension(pickedFiles[i].path.toLowerCase());
          if (extension == '.jpg' || extension == '.jpeg' ||
              extension == '.png') {
            sendMessage(MessageEntity(
              imageOrVideoOrAudioUrl:pickedFiles[i].path,
              messageType: MessageType.image,
              name: event.name,
              chatRoomId: event.chatRoomId,
              creatorUid: event.creatorUid,
              targetUserUid: event.targetUserUid,
              replyMessage: event.replyMessage,
            ));
          } else if (extension == '.mp4' || extension == '.mov' ||
              extension == '.avi') {
            sendMessage(MessageEntity(
              imageOrVideoOrAudioUrl:pickedFiles[i].path,
              messageType: MessageType.video,
              name: event.name,
              chatRoomId: event.chatRoomId,
              creatorUid: event.creatorUid,
              targetUserUid: event.targetUserUid,
              replyMessage: event.replyMessage,
            ));
          }
        }
      }
      } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

//TODO: Make Audio Message
  // _sendAudio (
  //
  //     ) {
  //   sendMessage(MessageEntity(
  //     imageOrVideoOrAudioUrl:,
  //     messageType: MessageType.image,
  //     name: event.name,
  //     chatRoomId: event.chatRoomId,
  //     creatorUid: event.creatorUid,
  //     targetUserUid: event.targetUserUid,
  //     replyMessage: event.replyMessage,
  //   ));
  // }


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
