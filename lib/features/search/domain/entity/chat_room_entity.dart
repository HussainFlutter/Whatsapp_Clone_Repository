import 'package:equatable/equatable.dart';

class ChatRoomEntity extends Equatable {
  // 5
  final String? chatRoomId;
  final List<String>? participants;
  final DateTime? createAt;
  final String? lastMessage;
  final DateTime? lastMessageCreateAt;

  const ChatRoomEntity({
     this.chatRoomId,
     this.participants,
     this.createAt,
     this.lastMessage,
     this.lastMessageCreateAt,
  });
  @override
  List<Object?> get props => [
    chatRoomId,
    participants,
    createAt,
    lastMessage,
    lastMessageCreateAt,
  ];
}
