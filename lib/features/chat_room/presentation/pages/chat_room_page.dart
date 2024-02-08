import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/show_emoji_picker_cubit.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';
import 'package:whatsapp_clone_repository/features/z_global_widgets/show_text_message.dart';
import '../../../../core/dependency_injection.dart';
import '../../data/model/message_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      appBar: ChatRoomAppBar(
        currentUser: widget.currentUser,
        targetUser: widget.targetUser,
      ),
      body: StreamBuilder(
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
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  0.25.sizeH(context),
                  Center(
                    child: InkWell(
                        onTap: () {}, child: const HelloAnimation()),
                  ),
                  0.5.sizeH(context),
                  MessageField(
                    chatRoomId: widget.chatRoomEntity.chatRoomId!,
                    currentUserUid: widget.currentUser.uid!,
                    messageController: messageController,
                    onTapOfEmoji: () {
                      //TODO: IMPLEMENT
                    },
                  ),
                  0.007.sizeH(context),
                ],
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ListView(
                      reverse: true,
                      shrinkWrap: true,
                      children: [
                        ChatRoomMessages(
                          messages: messages,
                        ),
                      ],
                    ),
                  ),
                  MessageField(
                    onTapOfEmoji: () {
                      context.read<ShowEmojiPickerCubit>().toggleEmojiPicker();
                    },
                    chatRoomId: widget.chatRoomEntity.chatRoomId!,
                    currentUserUid: widget.currentUser.uid!,
                    messageController: messageController,
                  ),
                  // 0.007.sizeH(context),
                  BlocBuilder<ShowEmojiPickerCubit ,ShowEmojiPickerState>(
                    builder: (context, state) {
                          return state.emojiToggle == true
                              ? SizedBox(
                            height: 0.3.mediaH(context),
                            child: EmojiPicker(
                              textEditingController: messageController,
                              // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                              config: const Config(
                                height: 256,
                                checkPlatformCompatibility: true,
                                swapCategoryAndBottomBar: false,
                                skinToneConfig: SkinToneConfig(),
                                categoryViewConfig: CategoryViewConfig(),
                                bottomActionBarConfig: BottomActionBarConfig(),
                                searchViewConfig: SearchViewConfig(),
                              ),
                            ),
                          )
                              : const SizedBox();
                    },
                  ),
                ],
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
    );
  }
}
