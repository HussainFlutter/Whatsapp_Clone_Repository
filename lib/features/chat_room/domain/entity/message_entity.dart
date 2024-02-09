import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? message;
  final String? messageId;
  final String? chatRoomId;
  final DateTime? createdAt;
  final String? creatorUid;
  final String? targetUserUid;
  final bool? isSeen;
  final bool? isSent;

  const MessageEntity({
      this.message,
      this.messageId,
      this.chatRoomId,
      this.createdAt,
      this.creatorUid,
      this.targetUserUid,
      this.isSeen,
      this.isSent,
      });
  @override
  List<Object?> get props => [
    message,
    messageId,
    targetUserUid,
    createdAt,
    chatRoomId,
    creatorUid,
    isSeen,
    isSent,
  ];
}
