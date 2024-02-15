import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/status/data/data_source/remote/status_remote_data_source.dart';
import 'package:whatsapp_clone_repository/features/status/data/model/status_model.dart';
import 'package:whatsapp_clone_repository/features/status/domain/entity/status_entity.dart';
import '../../../../../core/dependency_injection.dart';

class StatusRepoRemoteDataSourceImpl extends StatusRepoRemoteDataSource{
  final FirebaseFirestore firestore = sl<FirebaseFirestore>();

  @override
  Future<Either<void, Failure>> createStatus(StatusEntity statusEntity) async {
    try{
      final ref = firestore.collection(FirebaseConsts.status);
      final status = StatusModel(
        creatorUid: statusEntity.creatorUid,
        createAt: statusEntity.createAt,
        profilePic: statusEntity.profilePic,
        statusId: statusEntity.statusId,
        stories: statusEntity.stories,
        name: statusEntity.name,
      );
      await ref.doc(status.statusId)
      .set(status.toMap());
      return const Left(null);
    }catch(e)
    {
      customPrint(message: e.toString());
      throw const Right(Failure(message: "Failed creating status"));
    }
  }

  @override
  Future<Either<void, Failure>> deleteStatus(StatusEntity statusEntity) async {
    try{
      final ref = firestore.collection(FirebaseConsts.status);
      await ref.doc(statusEntity.statusId).delete();
      return const Left(null);
    }catch(e)
    {
      customPrint(message: e.toString());
      throw const Right(Failure(message: "Failed creating status"));

    }
  }

  @override
  Stream<StatusEntity> getMyStatus(StatusEntity statusEntity) {
    try{
      final ref = firestore.collection(FirebaseConsts.status);
      //Creator Uid will be the currentUsers uid
      return ref.where("creatorUid",isEqualTo: statusEntity.creatorUid)
          .limit(1)
          .where("createAt",isGreaterThan: DateTime.now().subtract(const Duration(hours: 24)))
          .snapshots().map((event) => StatusModel.fromSnapshot(event.docs.first));
    }catch(e) {
      customPrint(message: e.toString());
      throw const Failure(message: "Failed creating status");
    }
  }

  @override
  Stream<List<StatusEntity>> getStatus(StatusEntity statusEntity,UserEntity currentUser) {
    try{
      final ref = firestore.collection(FirebaseConsts.status);
      //Creator Uid will be the currentUsers uid
      return ref.where("creatorUid",whereIn: currentUser.chatRoomsWith)
      .where("createAt",isGreaterThan: DateTime.now().subtract(const Duration(hours: 24)))
      .snapshots()
      .map((event) => event.docs.map((e) => StatusModel.fromSnapshot(e)).toList());
    }catch(e) {
      customPrint(message: e.toString());
      throw const Failure(message: "Failed creating status");
    }
  }

  @override
  Future<Either<void, Failure>> updateStatus(StatusEntity statusEntity) async {
    // TODO: implement updateStatus
    try{
      final ref = firestore.collection(FirebaseConsts.status);
      await ref.doc(statusEntity.statusId)
      .update({
        "stories" : statusEntity.stories,
      });
      return const Left(null);
    }catch(e)
    {
      customPrint(message: e.toString());
      throw const Right(Failure(message: "Failed creating status"));
    }
  }

}