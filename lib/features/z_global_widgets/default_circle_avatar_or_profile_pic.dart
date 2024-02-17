

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

class DefaultCircleAvatar extends StatefulWidget {
  final String? url;
  final String? type;
   const DefaultCircleAvatar({super.key, this.url,this.type});

  @override
  State<DefaultCircleAvatar> createState() => _DefaultCircleAvatarState();
}

class _DefaultCircleAvatarState extends State<DefaultCircleAvatar> {
  String fetchedUrl = "assets/image_assets/default_profile_picture.jpg";
  bool loaded = false;
  void urlFunction () async {
   // print("hello");
   // print(widget.url);
    if(widget.url != null)
      {
        final fileName = await VideoThumbnail.thumbnailFile(
          video: widget.url!,
          imageFormat: ImageFormat.WEBP,
        );
        //print("File Name :"+fileName.toString());
        setState(() {
          if(fileName!.isNotEmpty)
            {
              fetchedUrl = fileName;
              loaded = true;
            }
        });
      }
  }

  @override
  void initState() {
    super.initState();
    widget.type == "video" ? urlFunction() : null;
    //print(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    //print("fetchedUrl  " + fetchedUrl.toString());
    // print(widget.url);
    // print(widget.type);
    // print(loaded);
    return widget.url == null || widget.url!.isEmpty
        ? const CircleAvatar(backgroundImage: AssetImage(
      "assets/image_assets/default_profile_picture.jpg",),)
        : widget.type == "video" ? CircleAvatar(backgroundColor: ColorsConsts.iconGrey,backgroundImage: loaded == true ? FileImage(File(fetchedUrl)) : AssetImage(fetchedUrl) as ImageProvider)
        : CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.url!),) ;
  }
}
