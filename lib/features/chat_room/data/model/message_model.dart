import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';

class MessageModel extends MessageEntity {
  final String? message;
  final String? messageId;
  final DateTime? createdAt;
  final String? creatorUid;
  final String? chatRoomId;
  final bool? isSeen;
  final bool? isSent;

  const MessageModel({
    this.message,
    this.messageId,
    this.createdAt,
    this.creatorUid,
    this.isSeen,
    this.chatRoomId,
    this.isSent,
  }) : super (
    message: message,
    messageId: messageId,
    createdAt: createdAt,
    creatorUid: creatorUid,
    chatRoomId: chatRoomId,
    isSeen: isSeen,
    isSent: isSent,
  );

  factory MessageModel.fromSnapshot (DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String,dynamic> ;
    return MessageModel(
      message: data["message"],
      messageId: data["messageId"],
      createdAt: data["createdAt"].toDate(),
      creatorUid: data["creatorUid"],
      isSeen: data["isSeen"],
      isSent: data["isSent"],
      chatRoomId: data["chatRoomId"],
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "message":message,
      "messageId":messageId,
      "createdAt":createdAt,
      "creatorUid":creatorUid,
      "isSeen":isSeen,
      "isSent":isSent,
      "chatRoomId":chatRoomId,
    };
  }

}
