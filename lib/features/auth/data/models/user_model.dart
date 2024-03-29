import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel extends UserEntity {
//7
  final String? name;
  final String? uid;
  final String? about;
  final String? phoneNumber;
  final String? profilePic;
  final bool? presence;
  final DateTime? createAt;
  final List<String?>? chatRoomsWith;

  const UserModel({
    this.name,
    this.chatRoomsWith,
    this.uid,
    this.about,
    this.phoneNumber,
    this.profilePic,
    this.presence,
    this.createAt,
  }) : super (
    name: name,
    uid: uid,
    about: about,
    phoneNumber: phoneNumber,
    profilePic: profilePic,
    presence: presence,
    createAt: createAt,
    chatRoomsWith: chatRoomsWith,
  );

  factory UserModel.fromSnapshot (DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String,dynamic>;
   // customPrint(message: snap.toString());
    return UserModel(
      name: snap["name"],
      uid: snap["uid"],
      about: snap["about"],
      phoneNumber: snap["phoneNumber"],
      profilePic: snap["profilePic"],
      presence: snap["presence"],
      createAt: snap["createAt"].toDate(),
      chatRoomsWith: List.from(snap["chatRoomsWith"]),
    );
  }

  Map<String,dynamic> toMap () {
    return {
      "name" : name,
      "uid" : uid,
      "about" : about,
      "phoneNumber" : phoneNumber,
      "profilePic" : profilePic,
      "presence" : presence,
      "createAt" : createAt,
      "chatRoomsWith" :chatRoomsWith,
    };
  }

}
