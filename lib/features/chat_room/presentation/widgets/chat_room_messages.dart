

import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';

import '../../../../core/constants.dart';

class ChatRoomMessages extends StatelessWidget {
  final List<MessageEntity> messages;
  const ChatRoomMessages({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    String? groupLabel;
    return Column(
      children: [
        SizedBox(
          height: 0.84.mediaH(context),
          child: GroupedListView(
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
                  decoration:  BoxDecoration(
                    color: ColorsConsts.textGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Text(
                    groupLabel == "Today" || groupLabel == "Yesterday" ? groupLabel!
                        :  DateFormat("dd:mm yy").format(
                        DateTime.parse(value)),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.timeGrey),
                  ),
                ),
              );
            },
            shrinkWrap: true,
            elements: messages,
            itemComparator: (item1, item2) => item1.createdAt!.compareTo(item2.createdAt!), //
            groupBy: (element) => DateTime(
              element.createdAt!.year,
              element.createdAt!.month,
              element.createdAt!.day,
            ).toString(),
            indexedItemBuilder:
                (context, elements, index) {
              return Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.02.mediaW(context),
                      vertical: 0.003.mediaH(context),
                    ),
                    child: ClipPath(
                      clipper: UpperNipMessageClipperTwo(
                          MessageType.send),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 0.35.mediaW(context),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal:
                          0.06.mediaW(context),
                          vertical: 0.01.mediaH(context),
                        ),
                        decoration: BoxDecoration(
                          color: ColorsConsts
                              .messageContainerGreen,
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            Text(
                              messages[index]
                                  .message!,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall,
                              maxLines: null,
                            ),
                            0.04.sizeW(context),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(
                                  vertical: 0.01
                                      .mediaW(
                                      context)),
                              child: Text(
                                DateFormat("hh:mm a")
                                    .format(
                                     messages[index]
                                    .createdAt!),
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                    fontSize: 0.034
                                        .mediaW(
                                        context),
                                    color: ColorsConsts
                                        .timeGrey),
                                maxLines: null,
                              ),
                            ),
                            0.02.sizeW(context),
                            Icon(
                              Icons.done_all,
                              size: 0.05.mediaW(context),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
