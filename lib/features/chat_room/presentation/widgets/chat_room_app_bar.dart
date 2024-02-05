

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';

import '../../../../core/constants.dart';
import '../../../z_global_widgets/default_circle_avatar_or_profile_pic.dart';

class ChatRoomAppBar extends StatelessWidget implements PreferredSize {
  final UserEntity currentUser;
  final UserEntity targetUser;
  const ChatRoomAppBar({super.key, required this.currentUser, required this.targetUser});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: ColorsConsts.whiteColor,
      ),
      automaticallyImplyLeading: false,
      backgroundColor: ColorsConsts.containerGreen,
      title: Row(
        children: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back)),
          DefaultCircleAvatar(url: targetUser.profilePic,),
          0.02.sizeW(context),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(currentUser.name!,style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),),
              Text(currentUser.presence! == false ? "Offline" : "Online",style: Theme.of(context).textTheme.displaySmall),
            ],
          ),
        ],
      ),
      actionsIconTheme: IconThemeData(
        color: ColorsConsts.whiteColor,
        size: 0.08.mediaW(context),
      ),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.videocam)),
        IconButton(onPressed: (){}, icon: const Icon(Icons.call)),
        PopupMenuButton(
            itemBuilder: (context){
              return [
                const PopupMenuItem(child: Text("Something")),
              ];
            })
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
