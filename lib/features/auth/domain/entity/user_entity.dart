import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? uid;
  final String? about;
  final String? phoneNumber;
  final String? profilePic;
  final bool? presence;
  final DateTime? createAt;

  const UserEntity({
    this.name,
    this.uid,
    this.about,
    this.phoneNumber,
    this.profilePic,
    this.presence,
    this.createAt,
  });

  @override
  List<Object?> get props => [
    name,
    uid,
    about,
    phoneNumber,
    profilePic,
    presence,
    createAt,
  ];
}
