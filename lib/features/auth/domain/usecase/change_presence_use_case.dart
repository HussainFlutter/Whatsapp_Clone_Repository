import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';
import '../../../../core/failures.dart';

class ChangePresenceUseCase {

  final AuthRepo repo;

  const ChangePresenceUseCase({required this.repo});

  Future<Either<void,Failure>> call (UserEntity user,bool presence)
  => repo.changePresence(user,presence);

}