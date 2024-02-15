

import 'package:whatsapp_clone_repository/features/status/domain/repo/status_repo.dart';

import '../../../auth/domain/entity/user_entity.dart';
import '../entity/status_entity.dart';

class GetStatusUseCase {
  final StatusRepo repo;

  GetStatusUseCase({required this.repo});

  Stream<List<StatusEntity>> call (StatusEntity statusEntity,UserEntity currentUser) => repo.getStatus(statusEntity, currentUser);
}