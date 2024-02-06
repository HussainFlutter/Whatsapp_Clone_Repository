

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/data/data_source/remote/chat_room_repo_data_source.dart';
import 'package:whatsapp_clone_repository/features/chat_room/data/model/message_model.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';

import '../../../../../core/dependency_injection.dart';

class ChatRoomRepoDataSourceImpl extends ChatRoomRepoDataSource{

  final FirebaseFirestore firestore = sl<FirebaseFirestore>();

  @override
  Future<Either<void, Failure>> sendMessage(MessageEntity messageEntity) async {
    final ref = firestore.collection(FirebaseConsts.chatRooms)
        .doc(messageEntity.chatRoomId)
        .collection("messages");
    try{

      final messageModel = MessageModel(
        message: messageEntity.message,
        messageId: randomId.v1(),
        chatRoomId: messageEntity.chatRoomId,
        creatorUid: messageEntity.creatorUid,
        createdAt: DateTime.now(),
        isSent: false,
        isSeen: false,
      );
      ref.doc(messageModel.messageId).set(messageModel.toMap()).then((value) {
        ref.doc(messageModel.messageId).update(
         {
           "isSent" : true,
         }
        );
      });
      return const Left(null);
    }catch(e){
      customPrint(message: e.toString());
      throw Right(Failure(error: e.toString(),message: "Error occurred while sending message"));
    }
  }

  @override
  Future<Either<void, Failure>> updateMessage(MessageEntity messageEntity) async {
    final ref = firestore.collection(FirebaseConsts.chatRooms)
        .doc(messageEntity.chatRoomId)
        .collection("messages");
    try{
      if(messageEntity.message != null || messageEntity.message != "")
        {
          await ref.doc(messageEntity.messageId).update({
            "message":messageEntity.message,
          });
        }
      return const Left(null);
    }catch(e) {
      customPrint(message: e.toString());
      throw Right(Failure(error: e.toString(),message: "Error occurred while updating message"));
    }
  }

  @override
  Future<Either<void, Failure>> deleteMessage(MessageEntity messageEntity) async {
    final ref = firestore.collection(FirebaseConsts.chatRooms)
        .doc(messageEntity.chatRoomId)
        .collection("messages");
    try{
      if(messageEntity.message != null || messageEntity.message != "")
      {
        await ref.doc(messageEntity.messageId).delete();
      }
      return const Left(null);
    }catch(e) {
      customPrint(message: e.toString());
      throw Right(Failure(error: e.toString(),message: "Error occurred while deleting message"));
    }
  }

  @override
  Stream<Either<List<MessageEntity>, Failure>> getMessage(ChatRoomEntity chatRoomEntity) {
    List<MessageEntity> messages = [];
    try{
      return firestore.collection(FirebaseConsts.chatRooms)
          .doc(chatRoomEntity.chatRoomId)
          .collection("messages")
          .snapshots()
          .map((event) {
            messages =  event.docs.map((e) => MessageModel.fromSnapshot(e)).toList();
            if(messages.isEmpty)
              {
                return const Left([]);
              }
            else
              {
                return Left(messages);
              }

        });
    }catch(e) {
      throw Right(Failure(error: e.toString(),message: "Error occurred while fetching messages"));
    }
  }

}