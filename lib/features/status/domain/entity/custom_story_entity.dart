

import 'package:equatable/equatable.dart';

class CustomStoryEntity extends Equatable{
  final String? url;
  final String? caption;
  final String? type;
  final List<String>? viewers;
  const CustomStoryEntity({ this.url,  this.type,this.caption,this.viewers});


  factory CustomStoryEntity.fromJson (Map<String,dynamic> json) {
    return CustomStoryEntity(
      url: json["url"],
      type: json["type"],
      caption: json["caption"],
      viewers: json["viewers"],
    );
  }

  Map<String,dynamic> toMap () {
    return {
      "url" :url,
      "type" :type,
      "caption" : caption,
      "viewers" : viewers,
    };
  }


  @override
  List<Object?> get props => [url,type,caption,viewers];
}