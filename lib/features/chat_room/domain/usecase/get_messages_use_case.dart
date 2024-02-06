
import 'package:dartz/dartz.dart'show Either;
import 'package:whatsapp_clone_repository/features/chat_room/domain/repo/chat_room_repo.dart';
import '../../../../core/failures.dart';
import '../../../search/domain/entity/chat_room_entity.dart';
import '../entity/message_entity.dart';

class GetMessagesUseCase {
  final ChatRoomRepo repo;

  GetMessagesUseCase({required this.repo});

  Stream<Either<List<MessageEntity>,Failure>> call(ChatRoomEntity chatRoomEntity)
  => repo.getMessage(chatRoomEntity);

}