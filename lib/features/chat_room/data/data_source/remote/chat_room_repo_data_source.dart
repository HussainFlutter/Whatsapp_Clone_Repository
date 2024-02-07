

import 'package:dartz/dartz.dart'show Either;
import 'package:whatsapp_clone_repository/core/failures.dart';
import '../../../../search/domain/entity/chat_room_entity.dart';
import '../../../domain/entity/message_entity.dart';

abstract class ChatRoomRepoDataSource {
  Future<Either<void,Failure>> sendMessage(MessageEntity messageEntity);
  Future<Either<void,Failure>> deleteMessage(MessageEntity messageEntity);
  Future<Either<void,Failure>> updateMessage(MessageEntity messageEntity);
  Stream<List<MessageEntity>> getMessage(ChatRoomEntity chatRoomEntity);
}