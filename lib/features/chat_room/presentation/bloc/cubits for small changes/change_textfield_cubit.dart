import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import '../../../../../core/utils.dart';
import '../../../domain/usecase/send_message_use_case.dart';
part 'change_textfield_state.dart';

class ChangeTextFieldCubit extends Cubit<ChangeTextFieldState> {
  final SendMessageUseCase sendMessage;
  ChangeTextFieldCubit({required this.sendMessage}) : super(const ChangeTextFieldState(isRecording: false));
  FlutterSoundRecorder recorder = FlutterSoundRecorder();

  startRecording () async {
    final permission =
        await Permission.microphone.request();
    if (permission.isGranted) {
      await recorder.openRecorder();
      emit(const ChangeTextFieldState(isRecording: true));
      await recorder.startRecorder(toFile: "audio");
      // recorder.setSubscriptionDuration(const Duration(milliseconds: 100));
      // recorder.onProgress?.listen((event) {
      //   print(event.duration);
      // });
      //recorder.dispositionStream();

      //await recorder.openRecorder();
    } else {
      toast(message: "Grant microphone permission");
    }
  }
  stopRecording ({required MessageEntity messageEntity}) async {
    emit(const ChangeTextFieldState(isRecording: false));
    String? path = await recorder.stopRecorder();
    //await recorder.closeRecorder();
    customPrint(message: path.toString());
    recorder.closeRecorder();
    // Send voice message
    sendMessage(
      MessageEntity(
        imageOrVideoOrAudioUrl: path.toString(),
        messageType: messageEntity.messageType,
        creatorUid: messageEntity.creatorUid,
        chatRoomId: messageEntity.chatRoomId,
        name: messageEntity.name,
        replyMessage: messageEntity.replyMessage,
        targetUserUid: messageEntity.targetUserUid,
      ),
    );
  }
  Stream<RecordingDisposition> recorderProgress () {
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 100),
    );
    return recorder.onProgress!;
  }
}
