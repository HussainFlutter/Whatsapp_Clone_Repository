import 'package:whatsapp_clone_repository/features/chat_room/domain/usecase/upload_image_video_audio_use_case.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/change_icon_cubit.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/chat_room_bloc.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/delete_appbar/delete_app_bar_cubit.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/reply_cubit.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/show_emoji_picker_cubit.dart';
import '../../core/dependency_injection.dart';
import 'data/data_source/remote/chat_room_repo_data_source.dart';
import 'data/data_source/remote/chat_room_repo_data_source_impl.dart';
import 'data/repo/chat_room_repo_impl.dart';
import 'domain/repo/chat_room_repo.dart';
import 'domain/usecase/change_message_seen_status_use_case.dart';
import 'domain/usecase/delete_message_use_case.dart';
import 'domain/usecase/get_last_message_use_case.dart';
import 'domain/usecase/get_messages_use_case.dart';
import 'domain/usecase/send_message_use_case.dart';
import 'domain/usecase/update_message_use_case.dart';

Future<void> chatRoomInit () async {
  //Blocs
  sl.registerFactory(() => ChatRoomBloc(
    getMessages: sl<GetMessagesUseCase>(),
    sendMessage: sl<SendMessageUseCase>(),
    deleteMessage: sl<DeleteMessageUseCase>(),
    updateMessage: sl<UpdateMessageUseCase>(),
    changeStatus: sl<ChangeMessageSeenStatusUseCase>(),
  ));
  sl.registerFactory(() => ChangeIconCubit());
  sl.registerFactory(() => ShowEmojiPickerCubit());
  sl.registerLazySingleton(() => DeleteAppBarCubit());
  sl.registerLazySingleton(() => ReplyCubit());
  // Use cases for chat room
  sl.registerLazySingleton(() => SendMessageUseCase(repo: sl<ChatRoomRepo>()));
  sl.registerLazySingleton(() => DeleteMessageUseCase(repo: sl<ChatRoomRepo>()));
  sl.registerLazySingleton(() => UpdateMessageUseCase(repo: sl<ChatRoomRepo>()));
  sl.registerLazySingleton(() => GetMessagesUseCase(repo: sl<ChatRoomRepo>()));
  sl.registerLazySingleton(() => ChangeMessageSeenStatusUseCase(repo: sl<ChatRoomRepo>()));
  sl.registerLazySingleton(() => GetLastMessageUseCase(repo: sl<ChatRoomRepo>()));
  sl.registerLazySingleton(() => UploadImageOrVideoOrAudioUseCase(repo: sl<ChatRoomRepo>()));
  // Use cases for chat room

  //Repositories for chat room
  sl.registerLazySingleton<ChatRoomRepo>(
          () => ChatRoomRepoImpl(dataSource: sl<ChatRoomRepoDataSource>()));
  sl.registerLazySingleton<ChatRoomRepoDataSource>(
          () => ChatRoomRepoDataSourceImpl());
  sl.registerLazySingleton<ChatRoomRepoDataSourceImpl>(
          () => ChatRoomRepoDataSourceImpl());
  //Repositories for chat room
}