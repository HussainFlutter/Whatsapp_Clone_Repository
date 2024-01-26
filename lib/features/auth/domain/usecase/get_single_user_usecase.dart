import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/failures.dart';
import '../entity/user_entity.dart';

class GetSingleUserUseCase {

  final AuthRepo repo;

  const GetSingleUserUseCase({required this.repo});


  Stream<Either<List<UserEntity>,Failure>> call (UserEntity user)
  => repo.getSingleUser(user);

}