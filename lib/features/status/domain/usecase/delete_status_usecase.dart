

import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/status/domain/repo/status_repo.dart';

import '../../../../core/failures.dart';
import '../entity/status_entity.dart';

class DeleteStatusUseCase {
  final StatusRepo repo;

  DeleteStatusUseCase({required this.repo});

  Future<Either<void,Failure>> call (StatusEntity statusEntity) => repo.deleteStatus(statusEntity);
}