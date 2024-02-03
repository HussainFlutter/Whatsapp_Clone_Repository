

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';

class ChatRoomModel extends ChatRoomEntity {

  final String? chatRoomId;
  final List<String>? participants;
  final DateTime? createAt;
  final String? lastMessage;
  final DateTime? lastMessageCreateAt;

  const ChatRoomModel({
    this.chatRoomId,
    this.participants,
    this.createAt,
    this.lastMessage,
    this.lastMessageCreateAt,
  }) : super (
    chatRoomId: chatRoomId,
    participants: participants,
    lastMessage: lastMessage,
    lastMessageCreateAt: lastMessageCreateAt,
    createAt: createAt,
  );

  factory ChatRoomModel.fromSnapshot (DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String,dynamic>;
    return ChatRoomModel(
      chatRoomId: snap["chatRoomId"],
      participants: snap["participants"],
      lastMessage: snap["lastMessage"],
      lastMessageCreateAt: snap["lastMessageCreateAt"].toDate(),
      createAt: snap["createAt"].toDate(),
    );
  }

  Map<String,dynamic> toMap () {
    return {
      "chatRoomId" : chatRoomId,
      "participants" : participants,
      "lastMessage" : lastMessage,
      "lastMessageCreateAt" : lastMessageCreateAt,
      "createAt" : createAt,
    };
  }


}