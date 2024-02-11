




import '../entity/chat_room_entity.dart';
import '../repo/search_repo.dart';

class UnreadMessagesUseCase {
  final SearchRepo repo;

  UnreadMessagesUseCase({required this.repo});
  Stream<int> call (ChatRoomEntity chatRoomEntity,String currentUserUid)
  => repo.unreadMessages(chatRoomEntity, currentUserUid);

}