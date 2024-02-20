import 'package:equatable/equatable.dart';

enum MessageType {text,video,audio,image}

class MessageEntity extends Equatable {
  final String? message;
  final MessageType? messageType;
  final String? name;
  final String? messageId;
  final String? chatRoomId;
  final String? imageOrVideoOrAudioUrl;
  final DateTime? createdAt;
  final String? creatorUid;
  final String? targetUserUid;
  final bool? isSeen;
  final bool? isSent;
  final MessageEntity? replyMessage;

  const MessageEntity({
      this.replyMessage,
      this.name,
      this.imageOrVideoOrAudioUrl,
      this.message,
      this.messageType,
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
    imageOrVideoOrAudioUrl,
    messageType,
  ];
}
