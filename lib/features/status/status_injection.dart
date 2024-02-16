import 'package:whatsapp_clone_repository/features/status/data/data_source/remote/status_remote_data_source.dart';
import 'package:whatsapp_clone_repository/features/status/data/data_source/remote/status_remote_data_source_impl.dart';
import 'package:whatsapp_clone_repository/features/status/data/repo/status_repo_impl.dart';
import 'package:whatsapp_clone_repository/features/status/domain/usecase/create_status_usecase.dart';
import 'package:whatsapp_clone_repository/features/status/domain/usecase/upload_image_use_case.dart';
import 'package:whatsapp_clone_repository/features/status/presentation/bloc/get_my_status_cubit.dart';
import 'package:whatsapp_clone_repository/features/status/presentation/bloc/status_bloc.dart';
import '../../core/dependency_injection.dart';
import 'domain/repo/status_repo.dart';
import 'domain/usecase/delete_status_usecase.dart';
import 'domain/usecase/get_my_status_usecase.dart';
import 'domain/usecase/get_status_usecase.dart';
import 'domain/usecase/update_status_usecase.dart';

Future<void> statusInjection () async {
  //Use Cases
  sl.registerLazySingleton(() => CreateStatusUseCase(repo: sl()));
  sl.registerLazySingleton(() => DeleteStatusUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdateStatusUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetStatusUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetMyStatusUseCase(repo: sl()));
  sl.registerLazySingleton(() => UploadImageUseCase(repo: sl()));
  //Bloc
  sl.registerFactory(() => StatusBloc(
      update: sl<UpdateStatusUseCase>(),
      delete: sl<DeleteStatusUseCase>(),
      create: sl<CreateStatusUseCase>(),
      getStatus: sl<GetStatusUseCase>(),
      upload: sl<UploadImageUseCase>(),
  ));
  sl.registerFactory(() => GetMyStatusCubit(
    getMyStatus: sl<GetMyStatusUseCase>(),
  ));
  //Repos
  sl.registerLazySingleton<StatusRepo>(() => StatusRepoImpl(dataSource: sl<StatusRepoRemoteDataSource>()));
  sl.registerLazySingleton<StatusRepoRemoteDataSource>(() => StatusRepoRemoteDataSourceImpl());

}