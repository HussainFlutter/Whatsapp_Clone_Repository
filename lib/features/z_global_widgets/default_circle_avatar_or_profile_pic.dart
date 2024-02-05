

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

class DefaultCircleAvatar extends StatelessWidget {
  final String? url;
  const DefaultCircleAvatar({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return url == null || url!.isEmpty
        ? const CircleAvatar(backgroundImage: AssetImage(
      "assets/image_assets/default_profile_picture.jpg",),)
        : CircleAvatar(backgroundImage: NetworkImage(url!),) ;
  }
}
