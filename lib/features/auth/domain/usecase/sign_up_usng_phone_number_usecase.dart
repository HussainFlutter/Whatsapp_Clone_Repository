

import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/failures.dart';
import '../entity/user_entity.dart';

class SignUpUsingPhoneNumberUseCase {
  final AuthRepo repo;

  SignUpUsingPhoneNumberUseCase({required this.repo});

  Future<Either<void,Failure>> call (String verificationId,String smsCode) => repo.signUpUsingPhoneNumber(verificationId, smsCode);

}
