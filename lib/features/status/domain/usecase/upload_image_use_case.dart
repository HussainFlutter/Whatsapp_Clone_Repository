import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/status/domain/repo/status_repo.dart';

import '../../../../core/failures.dart';

class UploadImageUseCase {
  final StatusRepo repo;

  UploadImageUseCase({required this.repo});
  Future<Either<String,Failure>> call (String path)
  =>  repo.uploadImage(path);

}