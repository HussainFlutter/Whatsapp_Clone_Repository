




import 'package:dartz/dartz.dart'show Either;
import 'package:whatsapp_clone_repository/features/status/domain/entity/status_entity.dart';

import '../../../../../core/failures.dart';


abstract class StatusRepoRemoteDataSource {
  Future<Either<void,Failure>> createStatus (StatusEntity statusEntity);
  Future<Either<void,Failure>> deleteStatus (StatusEntity statusEntity);
  Future<Either<void,Failure>> updateStatus (StatusEntity statusEntity);
  Stream<List<StatusEntity>> getStatus (StatusEntity statusEntity);
  Stream<StatusEntity> getMyStatus (StatusEntity statusEntity);
}