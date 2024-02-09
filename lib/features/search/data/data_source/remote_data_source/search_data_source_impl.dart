

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/search/data/data_source/remote_data_source/search_data_source.dart';
import 'package:whatsapp_clone_repository/features/search/data/model/chat_room_model.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';

import '../../../../../core/dependency_injection.dart';
import '../../../../../core/utils.dart';

class SearchDataSourceImpl extends SearchDataSource {
  final FirebaseFirestore firestore = sl<FirebaseFirestore>();

  @override
  Future<Either<ChatRoomEntity, Failure>> createChatRoom(UserEntity currentUser,
      UserEntity targetUser,) async {
    try {
      final result;
      if(currentUser.uid! == targetUser.uid!)
        {
           result = await firestore.collection(FirebaseConsts.chatRooms)
              .where("chatUsers.${targetUser.uid}", isEqualTo : false)
              .get();
           if (result.docs.isEmpty) {
             Map<String,dynamic> ss = {
               currentUser.uid! : false,
             };
             // create new chatroom
             ChatRoomModel newChatRoom = ChatRoomModel(
               participants: [
                 currentUser.uid!,
                 targetUser.uid!,
               ],
               createAt: DateTime.now(),
               chatRoomId: randomId.v1(),
               lastMessage: null,
               lastMessageCreateAt: null,
               chatUsers: ss,
             );
             await firestore.collection(FirebaseConsts.chatRooms)
                 .doc(newChatRoom.chatRoomId)
                 .set(
               newChatRoom.toMap(),
             );
             return Left(newChatRoom);
           }
           else {
             // fetch the chatRoom
             return Left(ChatRoomModel.fromSnapshot(
                 result.docs[0]));
           }
        }
      else
        {
           result = await firestore.collection(FirebaseConsts.chatRooms)
              .where("chatUsers.${currentUser.uid}", isEqualTo : true)
              .where("chatUsers.${targetUser.uid}", isEqualTo: true)
              .get();
           if (result.docs.isEmpty) {
             Map<String,dynamic> ss = {
               targetUser.uid! : true ,
               currentUser.uid! : true,
             };
             // create new chatroom
             ChatRoomModel newChatRoom = ChatRoomModel(
               participants: [
                 currentUser.uid!,
                 targetUser.uid!,
               ],
               createAt: DateTime.now(),
               chatRoomId: randomId.v1(),
               lastMessage: null,
               lastMessageCreateAt: null,
               chatUsers: ss,
             );
             await firestore.collection(FirebaseConsts.chatRooms)
                 .doc(newChatRoom.chatRoomId)
                 .set(
               newChatRoom.toMap(),
             );
             return Left(newChatRoom);
           }
           else {
             // fetch the chatRoom
             return Left(ChatRoomModel.fromSnapshot(
                 result.docs[0]));
           }
        }
    }
    catch (e) {
      customPrint(message: e.toString());
      return const Right(
          Failure(message: "Error occurred while making / fetching chatroom"));
    }
  }

  @override
  Future<Either<void, Failure>> deleteChatRoom(
      ChatRoomEntity chatRoomEntity) async {
    try {
      await firestore.collection(FirebaseConsts.chatRooms).doc(
          chatRoomEntity.chatRoomId).delete();
      return const Left(null);
    } catch (e) {
      customPrint(message: e.toString());
      return const Right(
          Failure(message: "Error occurred while making / fetching chatroom"));
    }
  }
}