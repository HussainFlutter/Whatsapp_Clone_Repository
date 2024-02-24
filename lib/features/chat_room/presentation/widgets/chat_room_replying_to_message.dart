

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
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 0.05.mediaW(context)),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsConsts.iconGrey.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
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
                    message.messageType == MessageType.audio
                    ?Text(
                      "🎵 Audio",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall,
                      overflow: TextOverflow.ellipsis,
                    )
                    : message.messageType == MessageType.video
                    ? Text(
                      "🎥 Video",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall,
                      overflow: TextOverflow.ellipsis,
                    )
                    : message.messageType == MessageType.image
                    ? Text(
                      "📷 Image",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall,
                      overflow: TextOverflow.ellipsis,
                    )
                    : Text(
                      message.message!,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
