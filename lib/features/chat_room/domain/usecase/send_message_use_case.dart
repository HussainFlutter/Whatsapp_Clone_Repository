


import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/repo/chat_room_repo.dart';

import '../../../../core/failures.dart';
import '../entity/message_entity.dart';

class SendMessageUseCase {
  final ChatRoomRepo repo;

  SendMessageUseCase({required this.repo});

  Future<Either<void,Failure>> call(MessageEntity messageEntity)
  => repo.sendMessage(messageEntity);

}