

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_repository/features/status/domain/entity/status_entity.dart';

import '../../domain/entity/custom_story_entity.dart';

class StatusModel extends StatusEntity {
  final String? statusId;
  final String? profilePic;
  final String? creatorUid;
  final String? name;
  final DateTime? createAt;
  final List<CustomStoryEntity>? stories;

  const StatusModel({
    this.statusId,
    this.profilePic,
    this.creatorUid,
    this.name,
    this.createAt,
    this.stories
  }) : super(
    statusId: statusId,
    profilePic: profilePic,
    creatorUid: creatorUid,
    name: name,
    createAt: createAt,
    stories: stories,
  );

  factory StatusModel.fromSnapshot (DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String,dynamic>;
    final stories = snap['stories'] as List;
    List<CustomStoryEntity> storiesData =
    stories.map((element) => CustomStoryEntity.fromJson(element)).toList();
    return StatusModel(
      statusId: snap["statusId"],
      profilePic: snap["profilePic"],
      creatorUid: snap["creatorUid"],
      name: snap["name"],
      createAt: snap["createAt"].toDate(),
      stories:storiesData,
    );
  }

  Map<String,dynamic> toMap () {
    return {
      "statusId" : statusId,
      "profilePic" : profilePic,
      "creatorUid" : creatorUid,
      "name" : name,
      "createAt" : createAt,
      "stories" : stories?.map((story) => story.toMap()).toList(),
    };
  }

}