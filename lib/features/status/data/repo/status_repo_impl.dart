



import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/status/data/data_source/remote/status_remote_data_source.dart';
import 'package:whatsapp_clone_repository/features/status/domain/entity/status_entity.dart';
import 'package:whatsapp_clone_repository/features/status/domain/repo/status_repo.dart';

import '../../../auth/domain/entity/user_entity.dart';

class StatusRepoImpl extends StatusRepo {
  final StatusRepoRemoteDataSource dataSource;

  StatusRepoImpl({required this.dataSource});
  @override
  Future<Either<void, Failure>> createStatus(StatusEntity statusEntity)
  => dataSource.createStatus(statusEntity);

  @override
  Future<Either<void, Failure>> deleteStatus(StatusEntity statusEntity)
  => dataSource.deleteStatus(statusEntity);
  @override
  Stream<StatusEntity?> getMyStatus(StatusEntity statusEntity)
  => dataSource.getMyStatus(statusEntity);

  @override
  Stream<List<StatusEntity>?> getStatus(StatusEntity statusEntity,UserEntity currentUser)
  => dataSource.getStatus(statusEntity, currentUser);

  @override
  Future<Either<void, Failure>> updateStatus(StatusEntity statusEntity)
  => dataSource.updateStatus(statusEntity);

  @override
  Future<Either<String, Failure>> uploadImage(String path)
  => dataSource.uploadImage(path);

}