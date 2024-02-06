part of 'chat_room_bloc.dart';

abstract class ChatRoomState extends Equatable {
  const ChatRoomState();
  @override
  List<Object> get props => [];
}

class ChatRoomInitial extends ChatRoomState {}
class ChatRoomLoading extends ChatRoomState {}
class ChatRoomLoaded extends ChatRoomState {
  final List<MessageEntity> messages;

  const ChatRoomLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}