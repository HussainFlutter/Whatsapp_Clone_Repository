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

  const SendMessageEvent({required this.chatRoomId,required this.message,required this.creatorUid});
  @override
  List<Object?> get props => [chatRoomId,message,creatorUid];
}