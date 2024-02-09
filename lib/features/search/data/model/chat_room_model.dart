

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';

class ChatRoomModel extends ChatRoomEntity {

  final String? chatRoomId;
  final List<String>? participants;
  final DateTime? createAt;
  final String? lastMessage;
  final Map<String,dynamic>? chatUsers;
  final DateTime? lastMessageCreateAt;

  const ChatRoomModel({
    this.chatRoomId,
    this.chatUsers,
    this.participants,
    this.createAt,
    this.lastMessage,
    this.lastMessageCreateAt,
  }) : super (
    chatRoomId: chatRoomId,
    participants: participants,
    lastMessage: lastMessage,
    chatUsers: chatUsers,
    lastMessageCreateAt: lastMessageCreateAt,
    createAt: createAt,
  );

  factory ChatRoomModel.fromSnapshot (DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String,dynamic>;
    final participantsDynamic = snap["participants"];
    final List<String> participants = participantsDynamic.map<String>((e) {
      if (e is String) {
        return e;
      } else {
        throw const FormatException('Participant is not a string');
      }
    }).toList();
    DateTime? lastMessageCreateAt;
    if (snap["lastMessageCreateAt"] != null) {
      lastMessageCreateAt = snap["lastMessageCreateAt"].toDate();
    }
   // print(snap["chatUsers"] );
    return ChatRoomModel(
      chatRoomId: snap["chatRoomId"],
      participants: participants,
      chatUsers:  snap["chatUsers"] as Map<String,dynamic>,
      lastMessage: snap["lastMessage"],
      lastMessageCreateAt: lastMessageCreateAt,
      createAt: snap["createAt"].toDate(),
    );
  }

  Map<String,dynamic> toMap () {
    return {
      "chatRoomId" : chatRoomId,
      "chatUsers" : chatUsers,
      "participants" : participants as List<String>,
      "lastMessage" : lastMessage,
      "lastMessageCreateAt" : lastMessageCreateAt,
      "createAt" : createAt,
    };
  }


}