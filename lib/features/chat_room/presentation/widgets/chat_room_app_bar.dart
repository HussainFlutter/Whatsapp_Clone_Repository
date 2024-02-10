

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/data/models/user_model.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/get_single_user_usecase.dart';

import '../../../../core/constants.dart';
import '../../../../core/dependency_injection.dart';
import '../../../z_global_widgets/default_circle_avatar_or_profile_pic.dart';
import '../../../z_global_widgets/show_text_message.dart';

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
          StreamBuilder(
              stream: sl<GetSingleUserUseCase>().call(UserEntity(uid: targetUser.uid)),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    debugPrint("In appbar Data");
                     return snapshot.data!.fold((l) {
                      final UserEntity targetUserPresence = l[0];
                      return  Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(targetUserPresence.name!,style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),),
                            Text(targetUserPresence.presence! == false ? "Offline" : "Online",style: Theme.of(context).textTheme.displaySmall),
                          ],
                        ),
                      );
                    }, (r) {
                       return const ShowTextMessage(
                         message: "Failed to fetch",
                         textColor: ColorsConsts.redColor,
                       );
                    });
                  }
                  if (snapshot.hasError) {
                    return const ShowTextMessage(
                      message: "Some Error Occurred",
                      textColor: ColorsConsts.redColor,
                    );
                  }
                  else {
                    return const SizedBox();
                  }
                }
                 else {
                  return const SizedBox();
                }
              }
          ),
        ],
      ),
      actionsIconTheme: IconThemeData(
        color: ColorsConsts.whiteColor,
        size: 0.07.mediaW(context),
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
