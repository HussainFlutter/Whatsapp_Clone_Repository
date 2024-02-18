

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
        targetUserUid: messageEntity.targetUserUid,
        messageId: randomId.v1(),
        chatRoomId: messageEntity.chatRoomId,
        creatorUid: messageEntity.creatorUid,
        createdAt: DateTime.fromMicrosecondsSinceEpoch(DateTime.now().microsecondsSinceEpoch),
        isSent: false,
        isSeen: false,
        name: messageEntity.name,
      );
       ref.doc(messageModel.messageId).set(messageModel.toMap()).then((value) async {
        await ref.doc(messageModel.messageId).update(
         {
           "isSent" : true,
         }
        ).then((value) {
           firestore.collection(FirebaseConsts.chatRooms)
              .doc(messageEntity.chatRoomId)
              .update({
              "lastMessage":messageModel.message,
              "lastMessageCreateAt":messageModel.createdAt,
          });
        });
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
         ref.doc(messageEntity.messageId).delete();
         //ref.where("createAt")
         //TODO: implement this logic here
         firestore.collection(FirebaseConsts.chatRooms)
             .doc(messageEntity.chatRoomId).update({
           "lastMessage": "You deleted this message",
           "lastMessageCreateAt" : DateTime.fromMicrosecondsSinceEpoch(DateTime.now().microsecondsSinceEpoch),
         });
      return const Left(null);
    }catch(e) {
      customPrint(message: e.toString());
      throw Right(Failure(error: e.toString(),message: "Error occurred while deleting message"));
    }
  }

  @override
  Stream<List<MessageEntity>> getMessage(ChatRoomEntity chatRoomEntity) {
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
                return [];
              }
            else
              {
                return messages;
              }

        });
    }catch(e) {
      throw Right(Failure(error: e.toString(),message: "Error occurred while fetching messages"));
    }
  }

  @override
  Stream<MessageEntity> getLastMessage(ChatRoomEntity chatRoomEntity) {
    try{
       return firestore.collection(FirebaseConsts.chatRooms)
          .doc(chatRoomEntity.chatRoomId)
          .collection("messages")
          .orderBy("createdAt",descending: true)
          .limit(1)
          .snapshots().map((event) => MessageModel.fromSnapshot(event.docs.first));
    }catch(e) {
      throw Right(Failure(error: e.toString(),message: "Error occurred while fetching messages"));
    }
  }

  @override
  Future<Either<void,Failure>> changeMessageSeenStatus (MessageEntity message) async {
    try{
      await firestore.collection(FirebaseConsts.chatRooms)
          .doc(message.chatRoomId)
          .collection(FirebaseConsts.messages)
          .doc(message.messageId)
          .update({
        "isSeen" : true,
      });
      return const Left(null);
    }catch(e)
    {
      customPrint(message: e.toString());
      throw const Right(Failure(message: "Something happened while updating isSeen "));
    }

  }

}