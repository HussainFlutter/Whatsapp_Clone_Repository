

import 'package:whatsapp_clone_repository/features/chat_room/domain/repo/chat_room_repo.dart';

import '../../../search/domain/entity/chat_room_entity.dart';
import '../entity/message_entity.dart';

class GetLastMessageUseCase {
  final ChatRoomRepo repo;

  GetLastMessageUseCase({required this.repo});

  Stream<MessageEntity> call(ChatRoomEntity chatRoomEntity)
  => repo.getLastMessage(chatRoomEntity);
}