


import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/repo/chat_room_repo.dart';

import '../../../../core/failures.dart';
import '../entity/message_entity.dart';

class DeleteMessageUseCase {
  final ChatRoomRepo repo;

  DeleteMessageUseCase({required this.repo});

  Future<Either<void,Failure>> call(MessageEntity messageEntity)
  => repo.deleteMessage(messageEntity);

}