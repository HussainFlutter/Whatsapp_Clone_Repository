import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/auth/data/data_source/remote/auth_data_repo.dart';
import 'package:whatsapp_clone_repository/features/auth/data/models/user_model.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRemoteDataSource extends AuthDataRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

   AuthRemoteDataSource({
    required this.firestore,
    required this.storage,
    required this.auth,
  });


  @override
  Future<Either<void, Failure>> signUpUsingPhoneNumber(UserEntity user, String smsCode) {
    // TODO: implement signUpUsingPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<Either<void, Failure>> createUser (UserEntity user) async {
    try{
      UserModel createUser = UserModel(
        name: user.name,
        uid: user.uid,
        phoneNumber: user.phoneNumber,
        profilePic: user.profilePic,
        about: user.about,
        presence: user.presence,
        createAt: user.createAt,
      );
      await firestore.collection(FirebaseConsts.users).doc(user.uid).set(
          createUser.toMap(),
      );
       return const Left(null);
    }catch(e)
    {
      return Right(Failure(error: e.toString(), message: "Failed creating user", errorCode: "no error code"));
    }
  }

  @override
  Future<Either<void, Failure>> deleteUser(UserEntity user) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<Either<String, Failure>> getCurrentUserUid() {
    // TODO: implement getCurrentUserUid
    throw UnimplementedError();
  }

  @override
  Stream<Either<List<UserEntity>, Failure>> getSingleUser(UserEntity user) {
    // TODO: implement getSingleUser
    throw UnimplementedError();
  }

  @override
  Stream<Either<List<UserEntity>, Failure>> getUsers(UserEntity user) {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<Either<bool, Failure>> isLogin() {
    // TODO: implement isLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<void, Failure>> updateUser(UserEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }


}
