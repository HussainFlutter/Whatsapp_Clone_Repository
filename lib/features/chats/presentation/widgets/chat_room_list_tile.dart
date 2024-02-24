

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/usecase/get_last_message_use_case.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';
import 'package:whatsapp_clone_repository/features/search/domain/usecase/unread_messages_use_case.dart';
import 'package:whatsapp_clone_repository/features/z_global_widgets/default_circle_avatar_or_profile_pic.dart';

import '../../../../core/constants.dart';
import '../../../../core/dependency_injection.dart';

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
      leading: DefaultCircleAvatar(url: targetUser.profilePic,),
      title: Text(
        currentUser.uid == targetUser.uid ? "(You)" : targetUser.name!,
        style: Theme.of(context)
            .textTheme
            .displaySmall,
      ),
      subtitle: StreamBuilder(
        stream: sl<GetLastMessageUseCase>().call(ChatRoomEntity(chatRoomId: chatRoomFetchedList.chatRoomId)),
        builder: (context, snapshot) {
           MessageEntity? message;
          if(snapshot.hasData && snapshot.data != null)
            {
               message = snapshot.data;
            }
          else
            {
              message = null;
            }
          return Text(
            message == null ?
            "Say hi to your new friend!":
            message.messageType == MessageType.text?
               message.message ?? ""
            : message.messageType == MessageType.image?
                "Image"
            : message.messageType == MessageType.video?
                "Video"
            :message.messageType == MessageType.audio?
                "Audio"
                : "",
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(
                color: ColorsConsts.iconGrey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }
      ),
      trailing: StreamBuilder(
        stream: sl<GetLastMessageUseCase>().call(ChatRoomEntity(chatRoomId: chatRoomFetchedList.chatRoomId)),
        builder: (context, snapshot) {
       //   print(snapshot.data);
          DateTime? lastMessageCreateAt;
          if(snapshot.hasData)
          {
            lastMessageCreateAt = snapshot.data!.createdAt!;
          }
          else
          {
            lastMessageCreateAt = null;
          }
          return Column(
            children: [
              Text(
                lastMessageCreateAt == null
                    ? ""
                    : DateFormat("hh:mm a").format(
                    lastMessageCreateAt),
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(
                    color: ColorsConsts.iconGrey),
              ),
              StreamBuilder(
                  stream: sl<UnreadMessagesUseCase>().call(ChatRoomEntity(chatRoomId: chatRoomFetchedList.chatRoomId),currentUser.uid!),
                  builder: (context,snapshot){
                    if(snapshot.data == 0 || snapshot.data == null)
                      {
                        return const SizedBox();
                      }
                    else
                      {
                        return Container(
                          padding: EdgeInsets.all(0.01.mediaW(context)),
                          decoration: const BoxDecoration(
                              color: ColorsConsts.containerGreen,
                              shape: BoxShape.circle
                          ),
                          child: Text(snapshot.data! > 99 ? "99+":snapshot.data.toString(),style: Theme.of(context).textTheme.displaySmall,),
                        );
                      }
                  },
              )

            ],
          );
        }
      ),
    );
  }
}
