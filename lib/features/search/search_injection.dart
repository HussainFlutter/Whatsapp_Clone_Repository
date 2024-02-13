


import 'package:whatsapp_clone_repository/features/search/presentation/bloc/search_bloc.dart';

import '../../core/dependency_injection.dart';
import '../auth/domain/usecase/get_users_usecase.dart';
import 'data/data_source/remote_data_source/search_data_source.dart';
import 'data/data_source/remote_data_source/search_data_source_impl.dart';
import 'data/repo/search_repo_impl.dart';
import 'domain/repo/search_repo.dart';
import 'domain/usecase/create_chat_room_usecase.dart';
import 'domain/usecase/delete_chat_room_usecase.dart';
import 'domain/usecase/unread_messages_use_case.dart';

Future<void> searchInIt () async {
  //bloc
  sl.registerFactory(() => SearchBloc(
    getUsers: sl<GetUsersUseCase>(),
    createChatRoom: sl<CreateChatRoomUseCase>(),
  ));

  // Use cases for search
  sl.registerLazySingleton(() => CreateChatRoomUseCase(repo: sl<SearchRepo>()));
  sl.registerLazySingleton(() => DeleteChatRoomUseCase(repo: sl<SearchRepo>()));
  sl.registerLazySingleton(() => UnreadMessagesUseCase(repo: sl<SearchRepo>()));
  // Use cases for search

  //Repositories for search
  sl.registerLazySingleton<SearchRepo>(
          () => SearchRepoImpl(repo: sl<SearchDataSource>()));
  sl.registerLazySingleton<SearchDataSource>(
          () => SearchDataSourceImpl());
  sl.registerLazySingleton<SearchDataSourceImpl>(
          () => SearchDataSourceImpl());
  //Repositories for search
}