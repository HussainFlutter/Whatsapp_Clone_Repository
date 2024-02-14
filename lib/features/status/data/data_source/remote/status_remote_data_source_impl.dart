


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/status/data/data_source/remote/status_remote_data_source.dart';
import 'package:whatsapp_clone_repository/features/status/domain/entity/status_entity.dart';

import '../../../../../core/dependency_injection.dart';

class StatusRepoRemoteDataSourceImpl extends StatusRepoRemoteDataSource{
  //TODO: IMPLEMENT
  final FirebaseFirestore firestore = sl<FirebaseFirestore>();

  @override
  Future<Either<void, Failure>> createStatus(StatusEntity statusEntity) {
    // TODO: implement createStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<void, Failure>> deleteStatus(StatusEntity statusEntity) {
    // TODO: implement deleteStatus
    throw UnimplementedError();
  }

  @override
  Stream<StatusEntity> getMyStatus(StatusEntity statusEntity) {
    // TODO: implement getMyStatus
    throw UnimplementedError();
  }

  @override
  Stream<List<StatusEntity>> getStatus(StatusEntity statusEntity) {
    // TODO: implement getStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<void, Failure>> updateStatus(StatusEntity statusEntity) {
    // TODO: implement updateStatus
    throw UnimplementedError();
  }

}