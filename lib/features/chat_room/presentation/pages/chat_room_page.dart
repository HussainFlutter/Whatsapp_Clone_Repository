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

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }
//TODO: FIX cannot delete targetUser message
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size(kToolbarHeight, kToolbarHeight),
        child: BlocBuilder<DeleteAppBarCubit,DeleteAppBarState>(
          builder: (context,state){
            if (state.selected == true)
              {
                return  ChatRoomDeleteAppBar(
                  chatRoomId: widget.chatRoomEntity.chatRoomId!,
                  numberOfMessages: state.messagesSelected,
                );
              }
            else
              {
                return ChatRoomAppBar(
                  currentUser: widget.currentUser,
                  targetUser: widget.targetUser,
                );
              }
          },
        ),
      ),

      // 1==1 ? ChatRoomDeleteAppBar(
      //   messageEntity: MessageEntity(),
      // ) : ChatRoomAppBar(
      //   currentUser: widget.currentUser,
      //   targetUser: widget.targetUser,
      // ),
      body: PopScope(
        onPopInvoked: (e){
          context.read<ShowEmojiPickerCubit>().toggleEmojiPicker(changeEmoji: false);
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
                final List<MessageEntity> messages =
                    data!.docs.map((e) => MessageModel.fromSnapshot(e)).toList();
                return messages.isEmpty
                    //Hello animation
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Center(
                            child: InkWell(
                                onTap: () => context.read<ChatRoomBloc>().add(SendMessageEvent(
                                  targetUserUid: widget.targetUser.uid!,
                                  chatRoomId: widget.chatRoomEntity.chatRoomId!,
                                  message: "🤚",
                                  creatorUid: widget.currentUser.uid!,
                                )),
                                child: const HelloAnimation()),
                          ),
                        ),
                        MessageField(
                          targetUserUid: widget.targetUser.uid!,
                          onTap: () => FocusScope.of(context).unfocus(),
                          chatRoomId: widget.chatRoomEntity.chatRoomId!,
                          currentUserUid: widget.currentUser.uid!,
                          messageController: messageController,
                          onTapOfEmoji: () => context
                              .read<ShowEmojiPickerCubit>()
                              .toggleEmojiPicker(),
                        ),
                        BlocBuilder<ShowEmojiPickerCubit, ShowEmojiPickerState>(
                          builder: (context, state) {
                            return state.emojiToggle == true
                                ? SizedBox(
                              height: 0.3.mediaH(context),
                              child: EmojiPicker(
                                textEditingController: messageController,
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
                    ):
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
                                      currentUserUid: widget.currentUser.uid!,
                                      targetUserUid: widget.targetUser.uid!,
                                      messages: messages,
                                    ),
                                  ],
                                ),
                              ),
                              // Message field
                              MessageField(
                                targetUserUid: widget.targetUser.uid!,
                                onTap: () => context.read<ShowEmojiPickerCubit>().toggleEmojiPicker(changeEmoji: false),
                                onTapOfEmoji: () {
                                  if(FocusScope.of(context).hasFocus)
                                    {
                                      FocusScope.of(context).unfocus();
                                      context.read<ShowEmojiPickerCubit>().toggleEmojiPicker();
                                    }
                                  else
                                    {
                                      context
                                          .read<ShowEmojiPickerCubit>()
                                          .toggleEmojiPicker();
                                    }
                                } ,
                                chatRoomId: widget.chatRoomEntity.chatRoomId!,
                                currentUserUid: widget.currentUser.uid!,
                                messageController: messageController,
                              ),
                              // 0.007.sizeH(context),
                              // Emoji picker
                              BlocBuilder<ShowEmojiPickerCubit, ShowEmojiPickerState>(
                                builder: (context, state) {
                                  return state.emojiToggle == true
                                      ? SizedBox(
                                          height: 0.3.mediaH(context),
                                          child: EmojiPicker(
                                            textEditingController: messageController,
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
}
