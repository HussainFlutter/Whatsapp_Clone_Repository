import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import '../../../../core/constants.dart';
import '../bloc/change_icon_cubit.dart';
import '../bloc/chat_room_bloc.dart';
import 'chat_room_text_field.dart';

class MessageField extends StatelessWidget {
  final TextEditingController messageController;
  final String currentUserUid;
  final String chatRoomId;
  final VoidCallback onTapOfEmoji;
  const MessageField({
      super.key,
      required this.messageController,
      required this.currentUserUid,
      required this.chatRoomId,
      required this.onTapOfEmoji,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 0,
          child: Row(
            children: [
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: ColorsConsts.textGrey,
                        borderRadius: BorderRadius.circular(30)),
                    child: ChatRoomTextField(
                      onTapOfEmoji: onTapOfEmoji,
                      controller: messageController,
                      onChanged: (e) {
                        if (messageController.text.isEmpty ||
                            messageController.text == "") {
                          context.read<ChangeIconCubit>().changeIcon(false);
                        } else {
                          context.read<ChangeIconCubit>().changeIcon(true);
                        }
                      },
                    )),
              ),
              BlocBuilder<ChangeIconCubit, ChangeIconState>(
                  builder: (context, state) {
                if (state is ChangedIcon) {
                  return state.change == false
                      ? FloatingActionButton.small(
                          shape: const CircleBorder(),
                          backgroundColor: ColorsConsts.containerGreen,
                          onPressed: () {},
                          child: const Icon(
                            Icons.mic,
                            color: ColorsConsts.whiteColor,
                          ),
                        )
                      : FloatingActionButton.small(
                          shape: const CircleBorder(),
                          backgroundColor: ColorsConsts.containerGreen,
                          onPressed: () {
                            context.read<ChatRoomBloc>().add(SendMessageEvent(
                                  chatRoomId: chatRoomId,
                                  message: messageController.text,
                                  creatorUid: currentUserUid,
                                ));
                            messageController.clear();
                          },
                          child: Icon(
                            Icons.send,
                            size: 0.05.mediaW(context),
                            color: ColorsConsts.whiteColor,
                          ),
                        );
                }
                return const SizedBox();
              }),
            ],
          ),
        ),
      ],
    );
  }
}
