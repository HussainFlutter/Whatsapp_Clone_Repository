import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/failures.dart';
import 'package:whatsapp_clone_repository/features/auth/data/data_source/remote/auth_data_repo.dart';
import 'package:whatsapp_clone_repository/features/auth/data/models/user_model.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../core/utils.dart';

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
  Future<Either<void, Failure>> signUpUsingPhoneNumber(String verificationId, String smsCode) async {
    try{

      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

      await auth.signInWithCredential(credential);
      return const Left(null);
    }catch(e)
    {
      customPrint(message: e.toString());
      throw Right(Failure(error: e.toString(), message: "Failed Signing up user", errorCode: "no error code"));
    }
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
        chatRoomsWith: user.chatRoomsWith,
      );
      await firestore.collection(FirebaseConsts.users).doc(user.uid).set(
          createUser.toMap(),
      );
      return const Left(null);
    }catch(e)
    {
      customPrint(message: e.toString());
      throw Right(Failure(error: e.toString(), message: "Failed creating user", errorCode: "no error code"));
    }
  }

  @override
  Future<Either<void, Failure>> deleteUser(UserEntity user) async {
    try{
      await firestore.collection(FirebaseConsts.users).doc(user.uid).delete();
      return const Left(null);
    }
    catch(e){
      customPrint(message: e.toString());
      throw  Failure(message: "Error Occurred while deleting user",error: e.toString());
    }
  }

  @override
  Future<Either<String?, Failure>> getCurrentUserUid() async {
    try{
      return Left(auth.currentUser?.uid);
    }
    catch(e){
      customPrint(message: e.toString());
      throw Failure(message: "No Uid found",error: e.toString());
    }
  }

  @override
  Stream<Either<List<UserEntity>, Failure>> getSingleUser(UserEntity user) {
      try {
        return firestore
            .collection(FirebaseConsts.users)
            .where("uid", isEqualTo: user.uid)
            .limit(1)
            .snapshots()
            .map((QuerySnapshot querySnapshot) {
          final List<UserEntity> users = querySnapshot.docs
              .map((DocumentSnapshot document) => UserModel.fromSnapshot(document))
              .toList();
          customPrint(message: users.toString());
          if (users.isNotEmpty) {
            return Left(users);
          } else {
            return const Right(Failure(message: "No users found")); // Return an empty list if no users are found
          }
        });
      } catch (e) {
        customPrint(message: e.toString());
        throw const Right(Failure(message: "Error fetching user"));
      }
  }

  @override
  Stream<Either<List<UserEntity>, Failure>> getUsers (UserEntity user) {
    try{
      final users = firestore.collection(FirebaseConsts.users).snapshots();
      return users.map((event) {
        final List<UserEntity> fetchedUsers = event.docs.map((e) =>
            UserModel.fromSnapshot(e)).toList();
        if(fetchedUsers.isEmpty)
          {
            throw const Right(Failure(message: "No Users found"));
          }
        else
          {
            return Left(fetchedUsers);
          }
      });
    }
    catch(e){
      customPrint(message: e.toString());
      throw Right(Failure(message: "Error fetching users",error: e.toString()));
    }
  }

  @override
  Future<Either<bool, Failure>> isLogin() async {
    try{
      final  uid  = await getCurrentUserUid();
       String? uid2;
      uid.fold((l) {
        uid2 = l;
      }, (r) {
        uid2 = null;
      });

      if(uid2 == null || uid2 == "")
      {
        return const Left(false);
      }
      else
      {
        return const Left(true);
      }

    }
    catch(e){
      customPrint(message: e.toString());
      throw  Right(Failure(message: "Some error occurred during isLogin",error: e.toString()));
    }
  }

  @override
  Future<Either<void, Failure>> updateUser(UserEntity user) async {
    try{
    //  print(user);
       Map<String,dynamic> updatedUser = {};
      if(user.about != null && user.about != "")
        {
          updatedUser["about"] = user.about;
        }
       if(user.chatRoomsWith!.isNotEmpty)
       {
         updatedUser["chatRoomsWith"] = FieldValue.arrayUnion([user.chatRoomsWith![0]]);
       }
      if(user.name != null && user.name != "")
        {
          updatedUser["name"] = user.name;
        }
      if(user.phoneNumber != null && user.phoneNumber != "")
        {
          updatedUser["phoneNumber"] = user.phoneNumber;
        }
      if(user.presence != null)
        {
          updatedUser["presence"] = user.presence;
        }
       if(user.profilePic != null && user.profilePic != "")
       {
         updatedUser["profilePic"] = user.profilePic;
       }
       await firestore.collection(FirebaseConsts.users)
       .doc(user.uid)
       .update(
         updatedUser,
       );
       return const Left(null);
    }
    catch(e){
      customPrint(message: e.toString());
      throw  Right(Failure(message: "Some error occurred while updating user",error: e.toString()));
    }
  }

  @override
  Future<void> logOut() async {
    try{
      await auth.signOut();
    }catch(e){
      customPrint(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<void, Failure>> changePresence(UserEntity user, bool presence) async {
    try {
      await firestore
          .collection(FirebaseConsts.users)
          .doc(user.uid!)
          .update({
        "presence":presence,
      });
      return const Left(null);
    }catch(e){
      customPrint(message: e.toString());
      throw const Right(Failure(message: "Error occurred while changing presence"));
    }
  }


}
