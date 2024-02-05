import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';
import '../widgets/chat_room_app_bar.dart';

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
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.transparent,
          )),
          Expanded(
            flex: 0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorsConsts.textGrey,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: TextFormField(
                      controller: messageController,
                      maxLines: null,
                      style: Theme.of(context).textTheme.displaySmall,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: SizedBox(
                          width: 0.18.mediaW(context),
                          child: Row(
                            children: [
                              Transform.rotate(
                                  angle: 4,
                                  child: const Icon(Icons.attachment)),
                              0.02.sizeW(context),
                              const Icon(Icons.camera_alt),
                            ],
                          ),
                        ),
                        suffixIconColor: ColorsConsts.iconGrey,
                        prefixIconColor: ColorsConsts.iconGrey,
                        prefixIcon: const Icon(Icons.emoji_emotions),
                        hintStyle: const TextStyle(
                          color: ColorsConsts.iconGrey,
                        ),
                        hintText: "Message"
                      ),
                      onChanged: (e){
                        if(messageController.text.isEmpty || messageController.text == "")
                        {
                          setState(() {
                            isWriting = false;
                          });
                        }
                        else
                          {
                            setState(() {
                              isWriting = true;
                            });
                          }
                      },
                    ),
                  ),
                ),
                isWriting == false ?  FloatingActionButton.small(
                  shape: const CircleBorder(),
                    backgroundColor: ColorsConsts.containerGreen,
                    onPressed: (){

                    },
                  child: const Icon(Icons.mic,color: ColorsConsts.whiteColor,),
                )
               : FloatingActionButton.small(
                  shape: const CircleBorder(),
                  backgroundColor: ColorsConsts.containerGreen,
                  onPressed: (){

                  },
                  child:  Icon(Icons.send,size: 0.05.mediaW(context),color: ColorsConsts.whiteColor,),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      )
    );
  }
}
