

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';

import '../../../../core/constants.dart';

class ChatRoomListTile extends StatelessWidget {
  final UserEntity currentUser;
  final UserEntity targetUser;
  final ChatRoomEntity chatRoomFetchedList;
  const ChatRoomListTile({super.key, required this.currentUser, required this.targetUser, required this.chatRoomFetchedList});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (context.mounted) {
          Navigator.pushNamed(context,
              RouteNames.chatRoomPage,
              arguments: {
                "currentUser": currentUser,
                "targetUser": targetUser,
                "chatRoomEntity": chatRoomFetchedList,
              });
        }
      },
      leading: targetUser.profilePic == null ||
          targetUser.profilePic == ""
          ? const CircleAvatar(
        backgroundImage: AssetImage(
            "assets/image_assets/default_profile_picture.jpg"),
      )
          : CircleAvatar(
        backgroundImage: NetworkImage(
            targetUser.profilePic!),
      ),
      title: Text(
        currentUser.uid == targetUser.uid ? "(You)" : targetUser.name!,
        style: Theme.of(context)
            .textTheme
            .displaySmall,
      ),
      subtitle: Text(
        chatRoomFetchedList.lastMessage ??
            "Say hi to your new friend",
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(
            color: ColorsConsts.textGrey),
      ),
      trailing: Text(
        chatRoomFetchedList
            .lastMessageCreateAt ==
            null
            ? ""
            : DateFormat("mm-dd").format(
            chatRoomFetchedList
                .lastMessageCreateAt!),
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(
            color: ColorsConsts.textGrey),
      ),
    );
  }
}
