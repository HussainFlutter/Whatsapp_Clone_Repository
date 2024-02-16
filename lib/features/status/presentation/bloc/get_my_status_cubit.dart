import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_repository/features/status/domain/entity/status_entity.dart';

import '../../domain/usecase/get_my_status_usecase.dart';

part 'get_my_status_state.dart';

class GetMyStatusCubit extends Cubit<GetMyStatusState> {
  final GetMyStatusUseCase getMyStatus;
  GetMyStatusCubit({required this.getMyStatus}) : super(GetMyStatusInitial());

  getMyStatusFunc (String uid) {
    getMyStatus.call(StatusEntity(creatorUid:uid)).listen((status) {
      //print(status);
      emit(GetMyStatusLoaded(status: status));
    });
  }

}
