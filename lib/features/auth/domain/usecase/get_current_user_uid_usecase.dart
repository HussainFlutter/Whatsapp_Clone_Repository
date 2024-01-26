import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';
import '../../../../core/failures.dart';

class GetCurrentUserUidUseCase {

  final AuthRepo repo;

  const GetCurrentUserUidUseCase({required this.repo});

  Future<Either<String?,Failure>> call ()
  => repo.getCurrentUserUid();

}