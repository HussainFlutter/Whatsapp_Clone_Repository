
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/cubits%20for%20small%20changes/change_textfield_cubit.dart';

import '../../../../core/constants.dart';

class RecordingContainer extends StatefulWidget {
  final MessageEntity messageEntity;
  const RecordingContainer({super.key, required this.messageEntity});

  @override
  State<RecordingContainer> createState() => _RecordingContainerState();
}

class _RecordingContainerState extends State<RecordingContainer> with SingleTickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 600));
    animation = Tween<double>(begin: 1,end: 0).animate(animationController);
    animationController.forward();
    animationController.repeat(reverse: true);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   //animationController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorsConsts.textGrey,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 0.04.mediaW(context)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                0.02.sizeW(context),
                FadeTransition(
                    opacity: animation,
                    child: const Icon(Icons.mic,color: ColorsConsts.redColor,)),
                0.02.sizeW(context),
                StreamBuilder<RecordingDisposition>(
                    stream: context.read<ChangeTextFieldCubit>().recorderProgress(),
                  builder: (context,time){
                      final duration = time.data?.duration == null
                          ? Duration.zero
                      : time.data!.duration;
                         //  Timer.periodic(const Duration(seconds: 1), (timer) {
                         //     setState(() {
                         //       duration = duration + 1;
                         //     });
                         // });
                         String twoDigits(int n) => n.toString().padLeft(2,"0");
                         final twoDigitMinutes =
                         twoDigits(duration.inMinutes.remainder(60));
                         final twoDigitSeconds =
                         twoDigits(duration.inSeconds.remainder(60));
                         return Text(
                           "$twoDigitMinutes:$twoDigitSeconds",
                           style: Theme.of(context).textTheme.displaySmall,);

                },
                )

              ],
            ),
            IconButton(
                onPressed: (){
                  animationController.dispose();
                  context.read<ChangeTextFieldCubit>().stopRecording(
                    messageEntity: MessageEntity(
                      messageType: MessageType.audio,
                      creatorUid: widget.messageEntity.creatorUid,
                      chatRoomId: widget.messageEntity.chatRoomId,
                      name: widget.messageEntity.name,
                      replyMessage: widget.messageEntity.replyMessage,
                      targetUserUid: widget.messageEntity.targetUserUid,
                    ),
                  );
                },
                icon: const Icon(Icons.stop,color: ColorsConsts.redColor,)
            ),
          ],
        ),
      ),
    );
  }
}
