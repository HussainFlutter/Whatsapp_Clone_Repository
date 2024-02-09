

import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/chat_room/data/data_source/remote/chat_room_repo_data_source.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/repo/chat_room_repo.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';

class ChatRoomRepoImpl extends ChatRoomRepo {
  final ChatRoomRepoDataSource dataSource;

  ChatRoomRepoImpl({required this.dataSource});


  @override
  Future<Either<void, Failure>> sendMessage(MessageEntity messageEntity)
  => dataSource.sendMessage(messageEntity);

  @override
  Future<Either<void, Failure>> updateMessage(MessageEntity messageEntity)
  => dataSource.updateMessage(messageEntity);
  @override
  Future<Either<void, Failure>> deleteMessage(MessageEntity messageEntity)
  => dataSource.deleteMessage(messageEntity);

  @override
  Stream<List<MessageEntity>> getMessage(ChatRoomEntity chatRoomEntity)
  => dataSource.getMessage(chatRoomEntity);

  @override
  Future<Either<void, Failure>> changeMessageSeenStatus(MessageEntity message)
  => dataSource.changeMessageSeenStatus(message);
}