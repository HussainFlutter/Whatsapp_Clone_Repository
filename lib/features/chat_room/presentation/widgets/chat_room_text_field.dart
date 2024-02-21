import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import '../../../../core/constants.dart';
import '../bloc/chat_room_bloc.dart';

class ChatRoomTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String?) onChanged;
  final VoidCallback onTapOfEmoji;
  final VoidCallback onTap;
  final FocusNode focusNode;
  final String name;
  final String targetUserUid;
  final String creatorUid;
  final String chatRoomId;
  final MessageEntity? replyMessage;
  const ChatRoomTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onTapOfEmoji,
    required this.onTap,
    required this.focusNode,
    required this.name,
    required this.targetUserUid,
    required this.creatorUid,
    required this.replyMessage,
    required this.chatRoomId,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onTap: onTap,
      controller: controller,
      maxLines: null,
      style: Theme.of(context).textTheme.displaySmall,
      decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: SizedBox(
            width: 0.18.mediaW(context),
            child: Row(
              children: [
                Transform.rotate(
                    angle: 4, child: const Icon(Icons.attachment)),
                 Flexible(
                   child: IconButton(
                                   onPressed: (){
                    context.read<ChatRoomBloc>().add(
                        SendVideoOrImage(
                            replyMessage: replyMessage,
                            name: name,
                            targetUserUid: targetUserUid,
                            chatRoomId: chatRoomId,
                            creatorUid: creatorUid,
                        ));
                                   },
                                   icon:const Icon(Icons.camera_alt)),
                 ),
              ],
            ),
          ),
          suffixIconColor: ColorsConsts.iconGrey,
          prefixIconColor: ColorsConsts.iconGrey,
          prefixIcon: IconButton(
            onPressed: onTapOfEmoji,
            icon: const Icon(Icons.emoji_emotions),
          ),
          hintStyle: const TextStyle(
            color: ColorsConsts.iconGrey,
          ),
          hintText: "Message"),
      onChanged: onChanged,
    );
  }
}
