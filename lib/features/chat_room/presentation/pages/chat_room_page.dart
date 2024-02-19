import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/delete_appbar/delete_app_bar_cubit.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/show_emoji_picker_cubit.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/widgets/chat_room_delete_appbar.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';
import 'package:whatsapp_clone_repository/features/z_global_widgets/show_text_message.dart';
import '../../../../core/dependency_injection.dart';
import '../../data/model/message_model.dart';
import '../bloc/chat_room_bloc.dart';
import '../bloc/reply_cubit.dart';
import '../widgets/chat_room_app_bar.dart';
import '../widgets/chat_room_hello_animation.dart';
import '../widgets/chat_room_message_field.dart';
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
  bool toggleEmoji = false;
  String? groupLabel;
  final FocusNode focusNode = FocusNode();
  MessageEntity? replyMessage;

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
 //print(Timestamp.);
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size(kToolbarHeight, kToolbarHeight),
        child: BlocBuilder<DeleteAppBarCubit, DeleteAppBarState>(
          builder: (context, state) {
            if (state.selected == true) {
              return ChatRoomDeleteAppBar(
                chatRoomId: widget.chatRoomEntity.chatRoomId!,
                numberOfMessages: state.messagesSelected,
              );
            } else {
              return ChatRoomAppBar(
                currentUser: widget.currentUser,
                targetUser: widget.targetUser,
              );
            }
          },
        ),
      ),
      body: PopScope(
        onPopInvoked: (e) {
          context
              .read<ShowEmojiPickerCubit>()
              .toggleEmojiPicker(changeEmoji: false);
        },
        child: StreamBuilder(
          stream: sl<FirebaseFirestore>()
              .collection(FirebaseConsts.chatRooms)
              .doc(widget.chatRoomEntity.chatRoomId)
              .collection(FirebaseConsts.messages)
              .orderBy("createdAt", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                debugPrint("In Data");
                final data = snapshot.data;
                final List<MessageEntity> messages = data!.docs
                    .map((e) => MessageModel.fromSnapshot(e))
                    .toList();
                return messages.isEmpty
                    //Hello animation
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Center(
                              child: InkWell(
                                  onTap: () => context
                                      .read<ChatRoomBloc>()
                                      .add(SendMessageEvent(
                                        replyMessage:null,
                                        name: widget.targetUser.name!,
                                        targetUserUid: widget.targetUser.uid!,
                                        chatRoomId:
                                            widget.chatRoomEntity.chatRoomId!,
                                        message: "🤚",
                                        creatorUid: widget.currentUser.uid!,
                                      )),
                                  child: const HelloAnimation()),
                            ),
                          ),
                          MessageField(
                            focusNode: focusNode,
                            targetUserUid: widget.targetUser.uid!,
                            onTap: () => FocusScope.of(context).unfocus(),
                            chatRoomId: widget.chatRoomEntity.chatRoomId!,
                            name: widget.currentUser.name!,
                            currentUserUid: widget.currentUser.uid!,
                            messageController: messageController,
                            onTapOfEmoji: () => context
                                .read<ShowEmojiPickerCubit>()
                                .toggleEmojiPicker(),
                          ),
                          BlocBuilder<ShowEmojiPickerCubit,
                              ShowEmojiPickerState>(
                            builder: (context, state) {
                              return state.emojiToggle == true
                                  ? SizedBox(
                                      height: 0.3.mediaH(context),
                                      child: EmojiPicker(
                                        textEditingController:
                                            messageController,
                                        config: const Config(
                                          height: 256,
                                          checkPlatformCompatibility: true,
                                          swapCategoryAndBottomBar: false,
                                          skinToneConfig: SkinToneConfig(),
                                          categoryViewConfig:
                                              CategoryViewConfig(),
                                          bottomActionBarConfig:
                                              BottomActionBarConfig(),
                                          searchViewConfig: SearchViewConfig(),
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                        ],
                      )
                    :
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
//___________________________________________________________________________________________________________
                    //Chat Room
                    GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Chat Room
                            Flexible(
                              child: ListView(
                               reverse: true,
                                //shrinkWrap: true,
                                children: [
                                  ChatRoomMessages(
                                    onSwipedMessage: (message) =>
                                    replyToMessage(message),
                                    currentUserUid: widget.currentUser.uid!,
                                    targetUserUid: widget.targetUser.uid!,
                                    messages: messages,
                                  ),
                                ],
                              ),
                            ),
                            // Message field
                            BlocBuilder<ReplyCubit, ReplyState>(
                              builder: (context, state) {
                                    return MessageField(
                                      cancelReply: cancelReply,
                                      replyMessage: state.replyMessage,
                                      name: widget.currentUser.name!,
                                      focusNode: focusNode,
                                      targetUserUid: widget.targetUser.uid!,
                                      onTap: () {
                                        if (context
                                            .read<DeleteAppBarCubit>()
                                            .state
                                            .selected ==
                                            true) {
                                          context
                                              .read<DeleteAppBarCubit>()
                                              .changeSelected(
                                              selected: false, clear: true);
                                        }
                                        context
                                            .read<ShowEmojiPickerCubit>()
                                            .toggleEmojiPicker(changeEmoji: false);
                                      },
                                      onTapOfEmoji: () {
                                        if (FocusScope.of(context).hasFocus) {
                                          FocusScope.of(context).unfocus();
                                          context
                                              .read<ShowEmojiPickerCubit>()
                                              .toggleEmojiPicker();
                                        } else {
                                          context
                                              .read<ShowEmojiPickerCubit>()
                                              .toggleEmojiPicker();
                                        }
                                      },
                                      chatRoomId: widget.chatRoomEntity.chatRoomId!,
                                      currentUserUid: widget.currentUser.uid!,
                                      messageController: messageController,
                                    );
                              },
                            ),
                            // Emoji picker
                            BlocBuilder<ShowEmojiPickerCubit,
                                ShowEmojiPickerState>(
                              builder: (context, state) {
                                return state.emojiToggle == true
                                    ? SizedBox(
                                        height: 0.3.mediaH(context),
                                        child: EmojiPicker(
                                          textEditingController:
                                              messageController,
                                          config: const Config(
                                            height: 256,
                                            checkPlatformCompatibility: true,
                                            swapCategoryAndBottomBar: false,
                                            skinToneConfig: SkinToneConfig(),
                                            categoryViewConfig:
                                                CategoryViewConfig(),
                                            bottomActionBarConfig:
                                                BottomActionBarConfig(),
                                            searchViewConfig:
                                                SearchViewConfig(),
                                          ),
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            ),
                          ],
                        ),
                      );
              }
              if (snapshot.hasError) {
                return const ShowTextMessage(
                  message: "Some Error Occurred",
                  textColor: ColorsConsts.redColor,
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorsConsts.containerGreen,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return const ShowTextMessage(
                message: "Check your internet connection",
                textColor: ColorsConsts.redColor,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  replyToMessage(message) {
      context.read<ReplyCubit>().replyMessage(message);
      focusNode.requestFocus();
  }

  cancelReply() {
    context.read<ReplyCubit>().replyMessage(null);
  }
}
