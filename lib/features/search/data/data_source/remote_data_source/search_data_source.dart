
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';

import '../../../../auth/domain/entity/user_entity.dart';
abstract class SearchDataSource {
  Future<Either<ChatRoomEntity,Failure>> createChatRoom(UserEntity currentUser,UserEntity targetUser,);
  Future<Either<void,Failure>> deleteChatRoom(ChatRoomEntity chatRoomEntity);
}