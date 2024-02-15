import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  //7
  final String? name;
  final String? uid;
  final String? about;
  final String? phoneNumber;
  final String? profilePic;
  final bool? presence;
  final DateTime? createAt;
  final List<String?>? chatRoomsWith;

  const UserEntity({
    this.chatRoomsWith,
    this.name,
    this.uid,
    this.about,
    this.phoneNumber,
    this.profilePic,
    this.presence,
    this.createAt,
  });

   factory UserEntity.empty () {
     return UserEntity(
       name:  "",
       uid:  "",
       about:  "",
       phoneNumber:  "",
       profilePic:  "",
       presence:  false,
       createAt:  DateTime.now(),
     );
   }

  @override
  List<Object?> get props => [
    name,
    uid,
    about,
    phoneNumber,
    profilePic,
    presence,
    createAt,
    chatRoomsWith,
  ];
}
