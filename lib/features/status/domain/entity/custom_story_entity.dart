

import 'package:equatable/equatable.dart';

class CustomStoryEntity extends Equatable{
  final String? url;
  final String? caption;
  final String? type;

  const CustomStoryEntity({ this.url,  this.type,this.caption});


  factory CustomStoryEntity.fromJson (Map<String,dynamic> json) {
    return CustomStoryEntity(
      url: json["url"],
      type: json["type"],
      caption: json["caption"],
    );
  }

  Map<String,dynamic> toMap () {
    return {
      "url" :url,
      "type" :type,
      "caption" :caption,
    };
  }


  @override
  List<Object?> get props => [url,type,caption];
}