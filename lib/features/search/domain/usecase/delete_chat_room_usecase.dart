import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';
import 'package:whatsapp_clone_repository/features/search/domain/repo/search_repo.dart';

class DeleteChatRoomUseCase {
  final SearchRepo repo;

  DeleteChatRoomUseCase({required this.repo});
  Future<Either<void,Failure>> call (ChatRoomEntity chatRoomEntity) async => repo.deleteChatRoom(chatRoomEntity);
}