import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? message;
  final String? name;
  final String? messageId;
  final String? chatRoomId;
  final DateTime? createdAt;
  final String? creatorUid;
  final String? targetUserUid;
  final bool? isSeen;
  final bool? isSent;
  final MessageEntity? replyMessage;

  const MessageEntity({
      this.replyMessage,
      this.name,
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
    replyMessage,
    targetUserUid,
    createdAt,
    chatRoomId,
    creatorUid,
    isSeen,
    isSent,
    name,
  ];
}
