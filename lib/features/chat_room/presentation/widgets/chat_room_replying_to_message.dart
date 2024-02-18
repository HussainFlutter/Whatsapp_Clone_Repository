

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';

class ReplyingToMessage extends StatelessWidget {
  final MessageEntity message;
  final VoidCallback cancelReply;
  const ReplyingToMessage({super.key, required this.message, required this.cancelReply});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsConsts.iconGrey.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
                color: ColorsConsts.greenColor,
                width: 5,
              ),
            0.03.sizeW(context),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.name!,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall,
                          maxLines: null,
                        ),
                      ),
                      IconButton(onPressed: cancelReply,
                       icon: const Icon(Icons.close))
                    ],
                  ),
                  Text(
                    message.message!,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
