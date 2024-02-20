part of 'chat_room_bloc.dart';

abstract class ChatRoomEvent extends Equatable {
  const ChatRoomEvent();
  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends ChatRoomEvent {
  final String chatRoomId;
  final String message;
  final String creatorUid;
  final String targetUserUid;
  final String name;
  final MessageEntity? replyMessage;

  const SendMessageEvent({
    required this.replyMessage,
    required this.name,
    required this.targetUserUid,
    required this.chatRoomId,
    required this.message,
    required this.creatorUid,
  });
  @override
  List<Object?> get props => [chatRoomId,message,creatorUid,targetUserUid,name,replyMessage];
}
class ChangeIsSeenEvent extends ChatRoomEvent {
  final MessageEntity messageEntity;

  const ChangeIsSeenEvent({required this.messageEntity});
  @override
  List<Object?> get props => [messageEntity];
}
class DeleteMessageEvent extends ChatRoomEvent {
  final String messageId;
  final String chatroomId;

  const DeleteMessageEvent({required this.messageId,required this.chatroomId});
  @override
  List<Object?> get props => [messageId,chatroomId];
}
class SendVideoOrImage extends ChatRoomEvent {
  final String chatRoomId;
  final String creatorUid;
  final String targetUserUid;
  final String name;
  final MessageEntity? replyMessage;

  const SendVideoOrImage({
    required this.replyMessage,
    required this.name,
    required this.targetUserUid,
    required this.chatRoomId,
    required this.creatorUid,
  });
  @override
  List<Object?> get props => [chatRoomId,creatorUid,targetUserUid,name,replyMessage];
}