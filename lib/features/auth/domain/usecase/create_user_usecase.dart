import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';
import '../../../../core/failures.dart';

class CreateUserUseCase {

  final AuthRepo repo;

  const CreateUserUseCase({required this.repo});

  Future<Either<void,Failure>> call (UserEntity user)
  => repo.createUser(user);

}