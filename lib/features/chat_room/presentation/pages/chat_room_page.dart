import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/widgets/chat_room_text_field.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';
import '../bloc/change_icon_cubit.dart';
import '../bloc/chat_room_bloc.dart';
import '../widgets/chat_room_app_bar.dart';
import '../widgets/chat_room_messages.dart';

class ChatRoomPage extends StatefulWidget {
  final UserEntity currentUser;
  final UserEntity targetUser;
  final ChatRoomEntity chatRoomEntity;
  const ChatRoomPage({
    super.key,
    required this.currentUser,
    required this.targetUser,
    required this.chatRoomEntity,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  TextEditingController messageController = TextEditingController();
  bool isWriting = false;
  String? groupLabel;
  @override
  void initState() {
    super.initState();
    context
        .read<ChatRoomBloc>()
        .add(FetchMessagesEvent(chatRoomId: widget.chatRoomEntity.chatRoomId!));
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsConsts.backgroundColor,
        appBar: ChatRoomAppBar(
          currentUser: widget.currentUser,
          targetUser: widget.targetUser,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // All of the screen
              BlocBuilder<ChatRoomBloc, ChatRoomState>(
                builder: (context, state) {
                  if (state is ChatRoomLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: ColorsConsts.messageContainerGreen,
                    ));
                  }
                  if (state is ChatRoomLoaded) {
                    return state.messages.isEmpty
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //TODO: Make animation here
                            0.3.sizeH(context),
                            Center(
                                child: Text(
                                  "Say hi to your new Friend",
                                  style: Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            0.5.sizeH(context),
                          ],
                        )
                        : ChatRoomMessages(messages: state.messages,);
                  }
                  return const SizedBox();
                },
              ),
              // The Message TextFormField
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
                            controller: messageController,
                            onChanged: (e) {
                              if (messageController.text.isEmpty ||
                                  messageController.text == "") {
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
                                  context
                                      .read<ChatRoomBloc>()
                                      .add(SendMessageEvent(
                                        chatRoomId:
                                            widget.chatRoomEntity.chatRoomId!,
                                        message: messageController.text,
                                        creatorUid: widget.currentUser.uid!,
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
              0.007.sizeH(context),
            ],
          ),
        ));
  }
}
