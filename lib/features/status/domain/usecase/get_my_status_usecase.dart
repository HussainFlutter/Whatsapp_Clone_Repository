

import 'package:whatsapp_clone_repository/features/status/domain/repo/status_repo.dart';
import '../entity/status_entity.dart';

class GetMyStatusUseCase {
  final StatusRepo repo;

  GetMyStatusUseCase({required this.repo});

  Stream<StatusEntity> call (StatusEntity statusEntity) => repo.getMyStatus(statusEntity);
}