import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? message;
  final String? messageId;
  final DateTime? createdAt;
  final String? creatorUid;
  final bool? isSeen;
  final bool? isSent;

  const MessageEntity({
      this.message,
      this.messageId,
      this.createdAt,
      this.creatorUid,
      this.isSeen,
      this.isSent,
      });
  @override
  List<Object?> get props => [
    message,
    messageId,
    createdAt,
    creatorUid,
    isSeen,
    isSent,
  ];
}
