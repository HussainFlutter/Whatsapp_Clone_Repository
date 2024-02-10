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
  final String targetUserUid;
  final String chatRoomId;
  final VoidCallback onTapOfEmoji;
  final VoidCallback onTap;
  const MessageField({
      super.key,
      required this.messageController,
      required this.currentUserUid,
      required this.chatRoomId,
      required this.onTapOfEmoji,
      required this.onTap,
    required this.targetUserUid,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 0,
          child: Row(
            children: [
              Flexible(
                child: Container(
                    decoration: BoxDecoration(
                        color: ColorsConsts.textGrey,
                        borderRadius: BorderRadius.circular(30)),
                    child: ChatRoomTextField(
                      onTap: onTap,
                      onTapOfEmoji: onTapOfEmoji,
                      controller: messageController,
                      onChanged: (e) {
                        if (e!.isEmpty ||
                            e == "") {
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
                              targetUserUid: targetUserUid,
                                  chatRoomId: chatRoomId,
                                  message: messageController.text.trim(),
                                  creatorUid: currentUserUid,
                                ));
                            messageController.clear();
                            context.read<ChangeIconCubit>().changeIcon(false);
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
        0.01.sizeH(context),
      ],
    );
  }
}
