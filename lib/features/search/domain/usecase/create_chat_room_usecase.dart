

import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';
import 'package:whatsapp_clone_repository/features/search/domain/repo/search_repo.dart';

import '../../../auth/domain/entity/user_entity.dart';

class CreateChatRoomUseCase {
  final SearchRepo repo;

  CreateChatRoomUseCase({required this.repo});
  Future<Either<ChatRoomEntity,Failure>> call (UserEntity currentUser,UserEntity targetUser,) async => repo.createChatRoom(currentUser,targetUser);
}