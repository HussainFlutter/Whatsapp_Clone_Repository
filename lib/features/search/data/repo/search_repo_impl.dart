

import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';
import 'package:whatsapp_clone_repository/features/search/domain/repo/search_repo.dart';

import '../../../auth/domain/entity/user_entity.dart';
import '../data_source/remote_data_source/search_data_source.dart';

class SearchRepoImpl extends SearchRepo {
  final SearchDataSource repo;

   SearchRepoImpl({required this.repo});
  @override
  Future<Either<ChatRoomEntity, Failure>> createChatRoom(UserEntity currentUser,UserEntity targetUser,)
  async => repo.createChatRoom( currentUser, targetUser,);

  @override
  Future<Either<void, Failure>> deleteChatRoom(ChatRoomEntity chatRoomEntity)
  async => deleteChatRoom(chatRoomEntity);

  @override
  Stream<int> unreadMessages(ChatRoomEntity chatRoomEntity, String currentUserUid)
  => repo.unreadMessages(chatRoomEntity, currentUserUid);


}