import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';

class ChatRoomPage extends StatefulWidget {
  final UserEntity currentUser;
  final UserEntity targetUser;
  final ChatRoomEntity chatRoomEntity;
  const ChatRoomPage({
    super.key,
    required this.currentUser,
    required this.targetUser,
    required this.chatRoomEntity,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(widget.currentUser.name!),
            Text(widget.targetUser.name!),
            Text(widget.chatRoomEntity.chatRoomId!),
          ],
        ),
      ),
    );
  }
}
