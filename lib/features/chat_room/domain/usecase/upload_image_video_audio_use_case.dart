

import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';
import '../repo/chat_room_repo.dart';

class UploadImageOrVideoOrAudioUseCase {
  final ChatRoomRepo repo;

  UploadImageOrVideoOrAudioUseCase({required this.repo});

  Future<Either<String,Failure>> call(String path)
  => repo.uploadImageOrVideoOrAudio(path);

}