

import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/failures.dart';
import '../entity/user_entity.dart';

class GetUsersUseCase {

  final AuthRepo repo;

  const GetUsersUseCase({required this.repo});


  Stream<Either<List<UserEntity>,Failure>> call (UserEntity user)
  => repo.getUsers(user);

}