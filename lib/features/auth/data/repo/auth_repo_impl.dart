

import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/auth/data/data_source/remote/auth_data_repo.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {

  final AuthDataRepo dataSource;

   AuthRepoImpl({required this.dataSource});
  // Create Update and delete User
  @override
  Future<Either<void, Failure>> createUser(UserEntity user) => dataSource.createUser(user);
  @override
  Future<Either<void, Failure>> deleteUser(UserEntity user) => dataSource.deleteUser(user);
  @override
  Future<Either<void, Failure>> updateUser(UserEntity user) => dataSource.updateUser(user);
  // Create Update and delete User
  //GetCurrentUser Uid and isLogin
  @override
  Future<Either<String?, Failure>> getCurrentUserUid() => dataSource.getCurrentUserUid();
  @override
  Future<Either<bool, Failure>> isLogin() => dataSource.isLogin();
  //GetCurrentUser Uid and isLogin
  //Get Users and GetSingleUser
  @override
  Stream<Either<List<UserEntity>, Failure>> getSingleUser(UserEntity user) => dataSource.getSingleUser(user);
  @override
  Stream<Either<List<UserEntity>, Failure>> getUsers(UserEntity user) => dataSource.getUsers(user);

  @override
  Future<Either<void, Failure>> signUpUsingPhoneNumber( String verificationId,String smsCode) => dataSource.signUpUsingPhoneNumber(verificationId, smsCode);
  //Get Users and GetSingleUser
  @override
  Future<void> logOut() => dataSource.logOut();
}