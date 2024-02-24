import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/cubits%20for%20small%20changes/change_textfield_cubit.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/widgets/recording_container.dart';
import '../../../../core/constants.dart';
import '../bloc/cubits for small changes/change_icon_cubit.dart';
import '../bloc/chat_room_bloc.dart';
import '../bloc/cubits for small changes/reply_cubit.dart';
import 'chat_room_replying_to_message.dart';
import 'chat_room_text_field.dart';

class MessageField extends StatelessWidget {
  final TextEditingController messageController;
  final String currentUserUid;
  final String targetUserUid;
  final String name;
  final String chatRoomId;
  final VoidCallback onTapOfEmoji;
  final VoidCallback onTap;
  final FocusNode focusNode;
  final MessageEntity? replyMessage;
  final VoidCallback? cancelReply;
  const MessageField({
    super.key,
    required this.messageController,
    required this.currentUserUid,
    required this.chatRoomId,
    required this.onTapOfEmoji,
    required this.onTap,
    required this.targetUserUid,
    required this.focusNode,
    required this.name,
    this.replyMessage,
    this.cancelReply,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BlocBuilder<ChangeTextFieldCubit, ChangeTextFieldState>(
                builder: (context, state) {
              if (state.isRecording == true) {
                return  Flexible(
                  child: RecordingContainer(
                    messageEntity: MessageEntity(
                      creatorUid: currentUserUid,
                      targetUserUid: targetUserUid,
                      name: name,
                      chatRoomId: chatRoomId,
                      replyMessage: replyMessage,
                    ),
                  ),
                );
              } else {
                return Flexible(
                  child: Column(
                    children: [
                      replyMessage == null
                          ? const SizedBox()
                          : ReplyingToMessage(
                              cancelReply: cancelReply!,
                              message: replyMessage!,
                            ),
                      Container(
                          decoration: BoxDecoration(
                              color: ColorsConsts.textGrey,
                              borderRadius: BorderRadius.circular(30)),
                          child: ChatRoomTextField(
                            chatRoomId: chatRoomId,
                            replyMessage: replyMessage,
                            creatorUid: currentUserUid,
                            targetUserUid: targetUserUid,
                            name: name,
                            focusNode: focusNode,
                            onTap: onTap,
                            onTapOfEmoji: onTapOfEmoji,
                            controller: messageController,
                            onChanged: (e) {
                              if (e!.isEmpty || e == "") {
                                context
                                    .read<ChangeIconCubit>()
                                    .changeIcon(false);
                              } else {
                                context
                                    .read<ChangeIconCubit>()
                                    .changeIcon(true);
                              }
                            },
                          )),
                    ],
                  ),
                );
              }
            }),
            BlocBuilder<ChangeIconCubit, ChangeIconState>(
                builder: (context, state) {
              if (state is ChangedIcon) {
                return state.change == false
                    ? FloatingActionButton.small(
                        shape: const CircleBorder(),
                        backgroundColor: ColorsConsts.containerGreen,
                        onPressed: () {
                          context.read<ChangeTextFieldCubit>().startRecording();
                        },
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
                                name: name,
                                targetUserUid: targetUserUid,
                                chatRoomId: chatRoomId,
                                message: messageController.text.trim(),
                                creatorUid: currentUserUid,
                                replyMessage: replyMessage,
                              ));
                          messageController.clear();
                          context.read<ChangeIconCubit>().changeIcon(false);
                          context.read<ReplyCubit>().replyMessage(null);
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
        0.01.sizeH(context),
      ],
    );
  }
  // Widget _normalTextField (BuildContext context) {
  //  return Row(
  //    children: [
  //      Flexible(
  //        child: Column(
  //          children: [
  //            replyMessage == null ? const SizedBox() : ReplyingToMessage(cancelReply: cancelReply!,message:replyMessage!,),
  //            Container(
  //                decoration: BoxDecoration(
  //                    color: ColorsConsts.textGrey,
  //                    borderRadius: BorderRadius.circular(30)),
  //                child: ChatRoomTextField(
  //                  chatRoomId: chatRoomId,
  //                  replyMessage: replyMessage,
  //                  creatorUid: currentUserUid,
  //                  targetUserUid:targetUserUid ,
  //                  name: name,
  //                  focusNode: focusNode,
  //                  onTap: onTap,
  //                  onTapOfEmoji: onTapOfEmoji,
  //                  controller: messageController,
  //                  onChanged: (e) {
  //                    if (e!.isEmpty ||
  //                        e == "") {
  //                      context.read<ChangeIconCubit>().changeIcon(false);
  //                    } else {
  //                      context.read<ChangeIconCubit>().changeIcon(true);
  //                    }
  //                  },
  //                )),
  //          ],
  //        ),
  //      ),
  //      BlocBuilder<ChangeIconCubit, ChangeIconState>(
  //          builder: (context, state) {
  //            if (state is ChangedIcon) {
  //              return state.change == false
  //                  ? FloatingActionButton.small(
  //                shape: const CircleBorder(),
  //                backgroundColor: ColorsConsts.containerGreen,
  //                onPressed: () {},
  //                child: GestureDetector(
  //                  onLongPress: (){
  //
  //                  },
  //                  onLongPressCancel: (){
  //
  //                  },
  //                  child: const Icon(
  //                    Icons.mic,
  //                    color: ColorsConsts.whiteColor,
  //                  ),
  //                ),
  //              )
  //                  : FloatingActionButton.small(
  //                shape: const CircleBorder(),
  //                backgroundColor: ColorsConsts.containerGreen,
  //                onPressed: () {
  //                  context.read<ChatRoomBloc>().add(SendMessageEvent(
  //                    name: name,
  //                    targetUserUid: targetUserUid,
  //                    chatRoomId: chatRoomId,
  //                    message: messageController.text.trim(),
  //                    creatorUid: currentUserUid,
  //                    replyMessage: replyMessage,
  //                  ));
  //                  messageController.clear();
  //                  context.read<ChangeIconCubit>().changeIcon(false);
  //                  context.read<ReplyCubit>().replyMessage(null);
  //                },
  //                child: Icon(
  //                  Icons.send,
  //                  size: 0.05.mediaW(context),
  //                  color: ColorsConsts.whiteColor,
  //                ),
  //              );
  //            }
  //            return const SizedBox();
  //          }),
  //    ],
  //  );
  // }
  // Widget _recordingField (BuildContext context) {
  //   return Container(
  //       decoration: BoxDecoration(
  //       color: ColorsConsts.textGrey,
  //       borderRadius: BorderRadius.circular(30)),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //          FadeTransition(
  //              opacity: ,
  //              child: Icon(Icons.mic,color: ColorsConsts.redColor,)),
  //         Text("00:10",style: Theme.of(context).textTheme.displaySmall,),
  //       ],
  //     ),
  //   );
  // }
}
