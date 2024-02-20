import 'package:custom_clippers/custom_clippers.dart' as clippers;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/delete_appbar/delete_app_bar_cubit.dart';
import '../../../../core/constants.dart';
import '../bloc/chat_room_bloc.dart';


class ChatRoomMessages extends StatefulWidget {
  final List<MessageEntity> messages;
  final String currentUserUid;
  final String targetUserUid;
  final ValueChanged<MessageEntity> onSwipedMessage;
  const ChatRoomMessages({
      super.key,
      required this.messages,
      required this.currentUserUid,
      required this.targetUserUid,
      required this.onSwipedMessage,
  });

  @override
  State<ChatRoomMessages> createState() => _ChatRoomMessagesState();
}
class _ChatRoomMessagesState extends State<ChatRoomMessages> {
  List<int> selectedIndex = [];
  bool selected = false;
  String? groupLabel;
  @override
  Widget build(BuildContext context) {
    //Group label was here
    return PopScope(
      canPop: context.read<DeleteAppBarCubit>().state.selected == true
          ? false
          : true,
      onPopInvoked: (e) {
        context.read<DeleteAppBarCubit>().changeSelected(selected: false,clear:true);
      },
      child: GroupedListView(
        elements: widget.messages,
        //sort: false,
        // itemComparator: (item1, item2) =>
        //     item1.createdAt!.compareTo(item2.createdAt!),
        groupBy: (element) {
          DateTime dateTime = element.createdAt!;
          return  DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day,
          ).toString();
        },
        reverse: true,
        groupSeparatorBuilder: (String value) => _groupSeparatorBuilder(value),
        shrinkWrap: true,

        indexedItemBuilder: (context, elements, index) {
          if (widget.messages[index].targetUserUid == widget.currentUserUid) {
            if (widget.messages[index].isSeen == false) {
              context.read<ChatRoomBloc>().add(
                  ChangeIsSeenEvent(messageEntity: widget.messages[index]));
            }
          }
          return SwipeTo(
            animationDuration: const Duration(milliseconds: 100),
            onRightSwipe: (e) => widget.onSwipedMessage(widget.messages[index]),
            child: InkWell(
              onLongPress: () {
                if(widget.messages[index].creatorUid == widget.currentUserUid)
                  {
                   // debugPrint("on long press${context.read<DeleteAppBarCubit>().state.selected}");
                    context.read<DeleteAppBarCubit>().changeSelected(selected: true,index: index,messageId: widget.messages[index].messageId);
                  }
              },
              onTap: () => onTap(index),
              // {
              //   if(widget.messages[index].creatorUid == widget.currentUserUid)
              //     {
              //     debugPrint("on tap start ${context.read<DeleteAppBarCubit>().state.selected}");
              //  if (context.read<DeleteAppBarCubit>().state.selected == true) {
              //     if (context.read<DeleteAppBarCubit>().state.selectedIndex.contains(index)) {
              //       context.read<DeleteAppBarCubit>().changeSelected(selected: true,index: index,remove: true,messageId: widget.messages[index].messageId);
              //       if (context.read<DeleteAppBarCubit>().state.selectedIndex.isEmpty) {
              //         debugPrint("empty");
              //         context.read<DeleteAppBarCubit>().changeSelected(selected: false);
              //       }
              //       debugPrint("removed from list ${context.read<DeleteAppBarCubit>().state.selected}");
              //     } else {
              //       debugPrint("added to list ${context.read<DeleteAppBarCubit>().state.selected}");
              //       context.read<DeleteAppBarCubit>().changeSelected(selected: true,index: index,messageId: widget.messages[index].messageId);
              //     }
              //   }
              //   debugPrint(context.read<DeleteAppBarCubit>().state.selectedIndex.toString());
              //   debugPrint("on tap end ${context.read<DeleteAppBarCubit>().state.selected}");
              //     }
              // },
              child: BlocBuilder<DeleteAppBarCubit, DeleteAppBarState>(
                builder: (context, state) {
                  //When selected for delete
                  if(state.selectedIndex.contains(index)){
                  return _forDeleteMessage(index);
                  }
                  //Normal messages
                  else {
                    return _normalMessages (index);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _normalMessages (int index) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: widget.messages[index].creatorUid ==
          widget.currentUserUid
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.02.mediaW(context),
                  vertical: 0.003.mediaH(context),
                ),
                child: ClipPath(
                  clipper: clippers.UpperNipMessageClipperTwo(
                    widget.messages[index].creatorUid ==
                        widget.currentUserUid
                        ? clippers.MessageType.send
                        : clippers.MessageType.receive,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                      widget.messages[index].creatorUid ==
                          widget.currentUserUid
                          ? 0.06.mediaW(context)
                          : 0.06.mediaW(context),
                      vertical: 0.01.mediaH(context),
                    ),
                    margin: EdgeInsets.only(
                      right: widget.messages[index].creatorUid ==
                          widget.currentUserUid
                          ? 0
                          : 0.25.mediaW(context),
                      left: widget.messages[index].creatorUid ==
                          widget.currentUserUid
                          ? 0.25.mediaW(context)
                          : 0,
                    ),
                    decoration: BoxDecoration(
                      color: widget.messages[index].creatorUid ==
                          widget.currentUserUid
                          ? ColorsConsts.messageContainerGreen
                          : ColorsConsts.textGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        widget.messages[index].replyMessage != null
                        ? ifReplyMessage (index)
                        : const SizedBox(),
                        widget.messages[index].messageType == MessageType.text
                            ? _textMessage(index)
                            :  widget.messages[index].messageType == MessageType.image
                            ? _imageMessage(index)
                            : widget.messages[index].messageType == MessageType.video
                            ? _videoMessage(index)
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
  Widget ifReplyMessage (int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: ColorsConsts.textGrey.withOpacity(0.4),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 4,
              color: ColorsConsts.containerGreen,
            ),
            0.02.sizeW(context),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.currentUserUid == widget.messages[index].replyMessage!.creatorUid
                        ? "You"
                        :widget.messages[index].replyMessage!.name! ,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  Text(
                    widget.messages[index].replyMessage!.message!,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _forDeleteMessage (int index) {
    return Container(
      color: ColorsConsts.greenColor.withOpacity(0.2),
      child: Row(
        mainAxisAlignment: widget.messages[index].creatorUid ==
            widget.currentUserUid
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.02.mediaW(context),
                    vertical: 0.003.mediaH(context),
                  ),
                  child: ClipPath(
                    clipper: clippers.UpperNipMessageClipperTwo(
                      widget.messages[index].creatorUid ==
                          widget.currentUserUid
                          ? clippers.MessageType.send
                          : clippers.MessageType.receive,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                        widget.messages[index].creatorUid ==
                            widget.currentUserUid
                            ? 0.06.mediaW(context)
                            : 0.06.mediaW(context),
                        vertical: 0.01.mediaH(context),
                      ),
                      margin: EdgeInsets.only(
                        right: widget.messages[index].creatorUid ==
                            widget.currentUserUid
                            ? 0
                            : 0.25.mediaW(context),
                        left: widget.messages[index].creatorUid ==
                            widget.currentUserUid
                            ? 0.25.mediaW(context)
                            : 0,
                      ),
                      decoration: BoxDecoration(
                        color: widget.messages[index].creatorUid ==
                            widget.currentUserUid
                            ? ColorsConsts.messageContainerGreen
                            : ColorsConsts.textGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        children: [
                          Text(
                            widget.messages[index].message!,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall,
                            maxLines: null,
                          ),
                          0.04.sizeW(context),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.01.mediaW(context)),
                            child: Text(
                              DateFormat("hh:mm a").format(
                                  widget
                                  .messages[index].createdAt!),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                  fontSize:
                                  0.034.mediaW(context),
                                  color: ColorsConsts.timeGrey),
                              maxLines: null,
                            ),
                          ),
                          0.02.sizeW(context),
                          _seenIcon(index),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  void onTap (int index) {
      if(widget.messages[index].creatorUid == widget.currentUserUid)
      {
        //debugPrint("on tap start ${context.read<DeleteAppBarCubit>().state.selected}");
        if (context.read<DeleteAppBarCubit>().state.selected == true) {
          if (context.read<DeleteAppBarCubit>().state.selectedIndex.contains(index)) {
            context.read<DeleteAppBarCubit>().changeSelected(selected: true,index: index,remove: true,messageId: widget.messages[index].messageId);
            if (context.read<DeleteAppBarCubit>().state.selectedIndex.isEmpty) {
          //    debugPrint("empty");
              context.read<DeleteAppBarCubit>().changeSelected(selected: false);
            }
         //   debugPrint("removed from list ${context.read<DeleteAppBarCubit>().state.selected}");
          } else {
       //     debugPrint("added to list ${context.read<DeleteAppBarCubit>().state.selected}");
            context.read<DeleteAppBarCubit>().changeSelected(selected: true,index: index,messageId: widget.messages[index].messageId);
          }
        }
        debugPrint(context.read<DeleteAppBarCubit>().state.selectedIndex.toString());
     //   debugPrint("on tap end ${context.read<DeleteAppBarCubit>().state.selected}");
      }
  }
  Widget _seenIcon (int index) {
    return widget.messages[index].creatorUid ==
        widget.currentUserUid
        ? widget.messages[index].isSent! ==
        true
        ? widget.messages[index]
        .isSeen! ==
        true
        ? Icon(
      Icons.done_all,
      size:
      0.05.mediaW(context),
      color: Colors.blue,
    )
        : Icon(
      Icons.done_all,
      size:
      0.05.mediaW(context),
      color:
      ColorsConsts.iconGrey,
    )
        : Icon(
      Icons.access_time_outlined,
      size: 0.05.mediaW(context),
      color: ColorsConsts.iconGrey,
    )
        : const SizedBox();
  }
  Widget _groupSeparatorBuilder (String value) {
    DateTime now = DateTime.now();
    Duration duration = const Duration(hours: 24);
    DateTime yesterday = now.subtract(duration);
    DateTime messageDateTime = DateTime.parse(value);
    if (messageDateTime.year == now.year &&
        messageDateTime.month == now.month &&
        messageDateTime.day == now.day) {
      groupLabel = "Today";
    } else if (messageDateTime.year == yesterday.year &&
        messageDateTime.month == yesterday.month &&
        messageDateTime.day == yesterday.day) {
      groupLabel = "Yesterday";
    } else {
      groupLabel = value;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 0.01.mediaW(context),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 0.3.mediaW(context),
        ),
        decoration: BoxDecoration(
          color: ColorsConsts.textGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          groupLabel == "Today" || groupLabel == "Yesterday"
              ? groupLabel!
              : DateFormat("MMMM dd,yyyy")
              .format(DateTime.parse(groupLabel!)),
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: ColorsConsts.timeGrey),
        ),
      ),
    );
  }
  Widget _textMessage (int index) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: [
        Text(
          textAlign: TextAlign.end,
          widget.messages[index].message!,
          style: Theme.of(context)
              .textTheme
              .displaySmall,
          maxLines: null,
        ),
        0.04.sizeW(context),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 0.01.mediaW(context)),
          child: Text(
            DateFormat("hh:mm a").format(widget
                .messages[index].createdAt!),
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(
                fontSize:
                0.034.mediaW(context),
                color: ColorsConsts.timeGrey),
            maxLines: null,
          ),
        ),
        0.02.sizeW(context),
        _seenIcon(index),
      ],
    );
  }
  Widget _imageMessage (int index) {
   //TODO: implement
  }
  Widget _videoMessage (int index) {
    //TODO: implement
  }
}
// {
//   DateTime now = DateTime.now();
//   Duration duration = const Duration(hours: 24);
//   DateTime yesterday = now.subtract(duration);
//   DateTime messageDateTime = DateTime.parse(value);
//   if (messageDateTime.year == now.year &&
//       messageDateTime.month == now.month &&
//       messageDateTime.day == now.day) {
//     groupLabel = "Today";
//   } else if (messageDateTime.year == yesterday.year &&
//       messageDateTime.month == yesterday.month &&
//       messageDateTime.day == yesterday.day) {
//     groupLabel = "Yesterday";
//   } else {
//     groupLabel = value;
//   }
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Container(
//       padding: EdgeInsets.symmetric(
//         vertical: 0.01.mediaW(context),
//       ),
//       margin: EdgeInsets.symmetric(
//         horizontal: 0.3.mediaW(context),
//       ),
//       decoration: BoxDecoration(
//         color: ColorsConsts.textGrey,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Text(
//         groupLabel == "Today" || groupLabel == "Yesterday"
//             ? groupLabel!
//             : DateFormat("MMMM dd,yyyy")
//                 .format(DateTime.parse(groupLabel!)),
//         textAlign: TextAlign.center,
//         style: Theme.of(context)
//             .textTheme
//             .displaySmall!
//             .copyWith(color: ColorsConsts.timeGrey),
//       ),
//     ),
//   );
// },
