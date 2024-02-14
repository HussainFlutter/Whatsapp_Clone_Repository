

import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/status/domain/repo/status_repo.dart';

import '../../../../core/failures.dart';
import '../entity/status_entity.dart';

class GetStatusUseCase {
  final StatusRepo repo;

  GetStatusUseCase({required this.repo});

  Stream<List<StatusEntity>> call (StatusEntity statusEntity) => repo.getStatus(statusEntity);
}