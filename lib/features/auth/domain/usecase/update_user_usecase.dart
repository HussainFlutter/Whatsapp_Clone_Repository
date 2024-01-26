


import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';
import '../../../../core/failures.dart';

class UpdateUserUseCase {

  final AuthRepo repo;

  const UpdateUserUseCase({required this.repo});

  Future<Either<void,Failure>> call (UserEntity user)
  => repo.updateUser(user);

}