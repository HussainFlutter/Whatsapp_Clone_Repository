import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';

part 'reply_state.dart';

class ReplyCubit extends Cubit<ReplyState> {
  ReplyCubit() : super(const ReplyState(replyMessage: null));
void replyMessage (MessageEntity? replyMessage) {
    emit(ReplyState(replyMessage: replyMessage));
  }
}
