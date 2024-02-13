import 'package:whatsapp_clone_repository/features/auth/presentation/bloc/login_bloc.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/bloc/splash_screen_bloc.dart';
import '../../core/dependency_injection.dart';
import 'data/data_source/remote/auth_data_repo.dart';
import 'data/data_source/remote/auth_remote_data_source.dart';
import 'data/repo/auth_repo_impl.dart';
import 'domain/repo/auth_repo.dart';
import 'domain/usecase/change_presence_use_case.dart';
import 'domain/usecase/create_user_usecase.dart';
import 'domain/usecase/delete_user_usecase.dart';
import 'domain/usecase/get_current_user_uid_usecase.dart';
import 'domain/usecase/get_single_user_usecase.dart';
import 'domain/usecase/get_users_usecase.dart';
import 'domain/usecase/is_login_usecase.dart';
import 'domain/usecase/log_out_use_case.dart';
import 'domain/usecase/sign_up_using_phone_number_usecase.dart';
import 'domain/usecase/update_user_usecase.dart';

Future<void> authInjection () async {
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
    changePresence: sl<ChangePresenceUseCase>(),
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
  sl.registerLazySingleton(() => ChangePresenceUseCase(repo: sl<AuthRepo>()));
  //Use Cases for user / auth

  //Repositories for user / auth
  sl.registerLazySingleton<AuthRepo>(
          () => AuthRepoImpl(dataSource: sl<AuthRemoteDataSource>()));
  sl.registerLazySingleton<AuthDataRepo>(
          () => AuthRemoteDataSource(auth: sl(), firestore: sl(), storage: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
          () => AuthRemoteDataSource(auth: sl(), firestore: sl(), storage: sl()));
  //Repositories for user / auth

}