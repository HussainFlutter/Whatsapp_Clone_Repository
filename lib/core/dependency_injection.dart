import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone_repository/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:whatsapp_clone_repository/features/auth/data/repo/auth_repo_impl.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/repo/auth_repo.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/get_single_user_usecase.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/get_users_usecase.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/is_login_usecase.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/sign_up_using_phone_number_usecase.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/update_user_usecase.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/bloc/login_bloc.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/bloc/splash_screen_bloc.dart';
import 'package:whatsapp_clone_repository/features/search/data/data_source/remote_data_source/search_data_source.dart';
import 'package:whatsapp_clone_repository/features/search/data/data_source/remote_data_source/search_data_source_impl.dart';
import 'package:whatsapp_clone_repository/features/search/data/repo/search_repo_impl.dart';
import 'package:whatsapp_clone_repository/features/search/domain/repo/search_repo.dart';
import 'package:whatsapp_clone_repository/features/search/domain/usecase/create_chat_room_usecase.dart';
import 'package:whatsapp_clone_repository/features/search/presentation/bloc/search_bloc.dart';
import '../features/auth/data/data_source/remote/auth_data_repo.dart';
import '../features/auth/domain/usecase/delete_user_usecase.dart';
import '../features/auth/domain/usecase/get_current_user_uid_usecase.dart';
import '../features/auth/domain/usecase/log_out_use_case.dart';
import '../features/search/domain/usecase/delete_chat_room_usecase.dart';

//Global variables

final GetIt sl = GetIt.instance;

const Uuid randomId = Uuid();

Future<void> init() async {
  //Blocs
  sl.registerFactory(() => SplashScreenBloc(
        isLogin: sl<IsLoginUseCase>(),
        getUid: sl<GetCurrentUserUidUseCase>(),
        getSingleUser: sl<GetSingleUserUseCase>(),
      ));
  sl.registerFactory(() => LoginBloc(
        getSingleUser: sl<GetSingleUserUseCase>(),
        signUp: sl<SignUpUsingPhoneNumberUseCase>(),
        getUid: sl<GetCurrentUserUidUseCase>(),
        createUser: sl<CreateUserUseCase>(),
        logOut: sl<LogOutUseCase>(),
      ));
  sl.registerFactory(() => SearchBloc(
        getUsers: sl<GetUsersUseCase>(),
        createChatRoom: sl<CreateChatRoomUseCase>(),
      ));
  //Use Cases for user / auth
  sl.registerLazySingleton(() => CreateUserUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => DeleteUserUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(
      () => GetCurrentUserUidUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => GetUsersUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => IsLoginUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => LogOutUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(
      () => SignUpUsingPhoneNumberUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repo: sl<AuthRepo>()));

  // Use cases for search
  sl.registerLazySingleton(() => CreateChatRoomUseCase(repo: sl<SearchRepo>()));
  sl.registerLazySingleton(() => DeleteChatRoomUseCase(repo: sl<SearchRepo>()));
  // Use cases for search

  //Repositories for user / auth
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(dataSource: sl<AuthRemoteDataSource>()));
  sl.registerLazySingleton<AuthDataRepo>(
      () => AuthRemoteDataSource(auth: sl(), firestore: sl(), storage: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSource(auth: sl(), firestore: sl(), storage: sl()));
  //Repositories for user / auth

  //Repositories for search
  sl.registerLazySingleton<SearchRepo>(
          () => SearchRepoImpl(repo: sl<SearchDataSource>()));
  sl.registerLazySingleton<SearchDataSource>(
          () => SearchDataSourceImpl());
  sl.registerLazySingleton<SearchDataSourceImpl>(
          () => SearchDataSourceImpl());
  //Repositories for search

  //External Sources
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
