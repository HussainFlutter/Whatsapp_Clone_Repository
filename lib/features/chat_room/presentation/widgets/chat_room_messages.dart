import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';

import '../../../../core/constants.dart';
import '../bloc/chat_room_bloc.dart';

class ChatRoomMessages extends StatefulWidget {
  final List<MessageEntity> messages;
  final String currentUserUid;
  final String targetUserUid;
  const ChatRoomMessages(
      {super.key,
      required this.messages,
      required this.currentUserUid,
      required this.targetUserUid});

  @override
  State<ChatRoomMessages> createState() => _ChatRoomMessagesState();
}
//TODO: REPLACE SET STATES WITH STATE MANAGEMENT TOOLS
class _ChatRoomMessagesState extends State<ChatRoomMessages> {
  List<int> selectedIndex = [];
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    String? groupLabel;
    return PopScope(
      canPop: selected == true ?false:true,
      onPopInvoked: (e){
        setState(() {
          selectedIndex.clear();
          selected = false;
        });
      },
      child: GroupedListView(
        sort: false,
        itemComparator: (item1, item2) =>
            item1.createdAt!.compareTo(item2.createdAt!), //
        groupBy: (element) => DateTime(
          element.createdAt!.year,
          element.createdAt!.month,
          element.createdAt!.day,
        ).toString(),
        reverse: true,
        groupSeparatorBuilder: (String value) {
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
        },
        shrinkWrap: true,
        elements: widget.messages,
        indexedItemBuilder: (context, elements, index) {
          if(widget.messages[index].targetUserUid == widget.currentUserUid)
            {
              if(widget.messages[index].isSeen == false)
                {
                  context.read<ChatRoomBloc>().add(ChangeIsSeenEvent(messageEntity: widget.messages[index]));
                }
            }
          return InkWell(
            onLongPress: (){
              setState(() {
                selected = true;
                selectedIndex.add(index);
              });
              print(selectedIndex);
            },
             onTap: (){
              print(selected);
               selected == true ? setState(() {
                 if(selectedIndex.isEmpty)
                 {
                   setState(() {
                     selected = false;
                   });
                 }
                 else if(selectedIndex.contains(index))
                   {
                     selectedIndex.remove(index);
                   }
                 else
                   {
                     selectedIndex.add(index);
                   }
              }) : null;
            },
            child: Container(
                color: selectedIndex.contains(index) ? ColorsConsts.greenColor.withOpacity(0.2) : null,
              child: Row(
                mainAxisAlignment: widget.messages[index].creatorUid == widget.currentUserUid
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
                            clipper: UpperNipMessageClipperTwo(
                              widget.messages[index].creatorUid == widget.currentUserUid
                                  ? MessageType.send
                                  : MessageType.receive,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    widget.messages[index].creatorUid == widget.currentUserUid
                                        ? 0.06.mediaW(context)
                                        : 0.06.mediaW(context),
                                vertical: 0.01.mediaH(context),
                              ),
                              margin: EdgeInsets.only(
                                right: widget.messages[index].creatorUid == widget.currentUserUid
                                    ? 0
                                    : 0.25.mediaW(context),
                                left: widget.messages[index].creatorUid == widget.currentUserUid
                                    ? 0.25.mediaW(context)
                                    : 0,
                              ),
                              decoration: BoxDecoration(
                                color: widget.messages[index].creatorUid == widget.currentUserUid
                                    ? ColorsConsts.messageContainerGreen
                                    : ColorsConsts.textGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                children: [
                                  Text(
                                    widget.messages[index].message!,
                                    style: Theme.of(context).textTheme.displaySmall,
                                    maxLines: null,
                                  ),
                                  0.04.sizeW(context),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.01.mediaW(context)),
                                    child: Text(
                                      DateFormat("hh:mm a")
                                          .format(widget.messages[index].createdAt!),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontSize: 0.034.mediaW(context),
                                              color: ColorsConsts.timeGrey),
                                      maxLines: null,
                                    ),
                                  ),
                                  0.02.sizeW(context),
                                  widget.messages[index].creatorUid == widget.currentUserUid
                                      ? widget.messages[index].isSent! == true
                                          ? widget.messages[index].isSeen! == true
                                              ? Icon(
                                                  Icons.done_all,
                                                  size: 0.05.mediaW(context),
                                                  color: Colors.blue,
                                                )
                                              : Icon(
                                                  Icons.done_all,
                                                  size: 0.05.mediaW(context),
                                                  color: ColorsConsts.iconGrey,
                                                )
                                          : Icon(
                                              Icons.access_time_outlined,
                                              size: 0.05.mediaW(context),
                                              color: ColorsConsts.iconGrey,
                                            )
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
              ),
            ),
          );
        },
      ),
    );
  }
}
