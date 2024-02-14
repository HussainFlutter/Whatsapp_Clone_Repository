import 'package:equatable/equatable.dart';

import 'custom_story_entity.dart';

enum StatusType { image, video, text }

class StatusEntity extends Equatable {
  final String? statusId;
  final String? profilePic;
  final String? creatorUid;
  final String? name;
  final DateTime? createAt;
  final List<CustomStoryEntity>? stories;

  const StatusEntity({
       this.statusId,
       this.profilePic,
       this.creatorUid,
       this.name,
       this.createAt,
       this.stories
      });

  @override
  List<Object?> get props => [
    statusId,
    profilePic,
    creatorUid,
    name,
    createAt,
    stories
  ];
}
