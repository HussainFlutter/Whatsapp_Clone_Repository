import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
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
import '../features/auth/data/data_source/remote/auth_data_repo.dart';
import '../features/auth/domain/usecase/delete_user_usecase.dart';
import '../features/auth/domain/usecase/get_current_user_uid_usecase.dart';

final GetIt sl = GetIt.instance;


Future<void> init () async {
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
      createUser: sl<CreateUserUseCase>()
  ));
  //Use Cases
  sl.registerLazySingleton(() => CreateUserUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => DeleteUserUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => GetCurrentUserUidUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => GetUsersUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => IsLoginUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => SignUpUsingPhoneNumberUseCase(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repo: sl<AuthRepo>()));
  //Repositories
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(dataSource: sl<AuthRemoteDataSource>()));
  sl.registerLazySingleton<AuthDataRepo>(() => AuthRemoteDataSource(auth: sl(),firestore: sl(),storage: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(auth: sl(),firestore: sl(),storage: sl()));

  //External Sources
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}