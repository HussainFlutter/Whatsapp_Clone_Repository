import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';

class MessageModel extends MessageEntity {
  final String? message;
  final MessageType? messageType;
  final String? messageId;
  final DateTime? createdAt;
  final String? creatorUid;
  final String? targetUserUid;
  final String? chatRoomId;
  final bool? isSeen;
  final bool? isSent;
  final String? name;
  final String? imageOrVideoOrAudioUrl;
  final MessageEntity? replyMessage;
  const MessageModel({
    this.message,
    this.imageOrVideoOrAudioUrl,
    this.messageType,
    this.replyMessage,
    this.name,
    this.messageId,
    this.createdAt,
    this.creatorUid,
    this.targetUserUid,
    this.isSeen,
    this.chatRoomId,
    this.isSent,
  }) : super (
    message: message,
    name: name,
    imageOrVideoOrAudioUrl: imageOrVideoOrAudioUrl,
    messageType: messageType,
    replyMessage: replyMessage,
    messageId: messageId,
    createdAt: createdAt,
    creatorUid: creatorUid,
    targetUserUid: targetUserUid,
    chatRoomId: chatRoomId,
    isSeen: isSeen,
    isSent: isSent,
  );
  factory MessageModel.fromSnapshot (DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String,dynamic> ;
    return MessageModel(
      messageType: data["messageType"],
      message: data["message"],
      imageOrVideoOrAudioUrl: data["imageOrVideoOrAudioUrl"],
      messageId: data["messageId"],
      createdAt:  data["createdAt"].toDate(),
      creatorUid: data["creatorUid"],
      targetUserUid: data["targetUserUid"],
      isSeen: data["isSeen"],
      isSent: data["isSent"],
      chatRoomId: data["chatRoomId"],
      name: data["name"],
      replyMessage: data["replyMessage"] == null ? null : MessageModel.fromMap(data["replyMessage"]),
    );
  }

  factory MessageModel.fromMap (Map<String,dynamic> data) {
    return MessageModel(
      message: data["message"],
      messageType: data["messageType"],
      imageOrVideoOrAudioUrl: data["imageOrVideoOrAudioUrl"],
      messageId: data["messageId"],
      createdAt: data["createdAt"].toDate(),
      creatorUid: data["creatorUid"],
      targetUserUid: data["targetUserUid"],
      isSeen: data["isSeen"],
      isSent: data["isSent"],
      chatRoomId: data["chatRoomId"],
      name: data["name"],
      replyMessage: null,
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "message":message,
      "imageOrVideoOrAudioUrl":imageOrVideoOrAudioUrl,
      "messageType":messageType,
      "name":name,
      "messageId":messageId,
      "createdAt":createdAt,
      "creatorUid":creatorUid,
      "targetUserUid":targetUserUid,
      "isSeen":isSeen,
      "isSent":isSent,
      "chatRoomId":chatRoomId,
      "replyMessage": replyMessage == null ? null : replyMessageToMap(replyMessage!),
    };
  }
  Map<String,dynamic> replyMessageToMap (MessageEntity replyMessage) {
    return {
      "message":replyMessage.message,
      "messageType":replyMessage.messageType,
      "name":replyMessage.name,
      "imageOrVideoOrAudioUrl":replyMessage.imageOrVideoOrAudioUrl,
      "messageId":replyMessage.messageId,
      "createdAt":replyMessage.createdAt,
      "creatorUid":replyMessage.creatorUid,
      "targetUserUid":replyMessage.targetUserUid,
      "isSeen":replyMessage.isSeen,
      "isSent":replyMessage.isSent,
      "chatRoomId":replyMessage.chatRoomId,
      "replyMessage": null,
    };
  }

}
