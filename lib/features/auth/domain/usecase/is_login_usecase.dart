import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';
import '../../../../core/failures.dart';

class IsLoginUseCase {

  final AuthRepo repo;

  const IsLoginUseCase({required this.repo});

  Future<Either<bool,Failure>> call ()
  => repo.isLogin();

}