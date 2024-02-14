

import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_repository/features/status/domain/entity/status_entity.dart';

class CustomStoryEntity extends Equatable{
  final String? url;
  final StatusType? type;

  const CustomStoryEntity({ this.url,  this.type});


  factory CustomStoryEntity.fromJson (Map<String,dynamic> json) {
    return CustomStoryEntity(
      url: json["url"],
      type: json["type"],
    );
  }

  Map<String,dynamic> toMap () {
    return {
      "url" :url,
      "type" :type,
    };
  }


  @override
  List<Object?> get props => [url,type];
}