

import 'package:dartz/dartz.dart' show Either;
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';

abstract class AuthDataRepo {
  Future<Either<void,Failure>> createUser (UserEntity user);
  Future<Either<void,Failure>> updateUser (UserEntity user);
  Future<Either<void,Failure>> deleteUser (UserEntity user);
  Future<void> logOut ();
  Future<Either<void,Failure>> signUpUsingPhoneNumber (String verificationId,String smsCode);
  Future<Either<String?,Failure>> getCurrentUserUid ();
  Future<Either<bool,Failure>> isLogin ();
  Stream<Either<List<UserEntity>,Failure>> getSingleUser (UserEntity user);
  Stream<Either<List<UserEntity>,Failure>> getUsers (UserEntity user);
  Future<Either<void,Failure>> changePresence (UserEntity user,bool presence);
}