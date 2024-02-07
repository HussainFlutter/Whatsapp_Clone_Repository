

import 'package:dartz/dartz.dart'show Either;
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';

abstract class ChatRoomRepo {
  Future<Either<void,Failure>> sendMessage(MessageEntity messageEntity);
  Future<Either<void,Failure>> deleteMessage(MessageEntity messageEntity);
  Future<Either<void,Failure>> updateMessage(MessageEntity messageEntity);
  Stream<List<MessageEntity>> getMessage(ChatRoomEntity chatRoomEntity);
}