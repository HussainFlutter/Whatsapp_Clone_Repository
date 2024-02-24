part of 'reply_cubit.dart';

 class ReplyState extends Equatable {

  final MessageEntity? replyMessage;

  const ReplyState({this.replyMessage});
  @override
  List<Object?> get props => [replyMessage];
}


