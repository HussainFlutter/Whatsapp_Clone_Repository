import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_icon_state.dart';

class ChangeIconCubit extends Cubit<ChangeIconState> {
  ChangeIconCubit() : super(const ChangedIcon(change: false));
  void changeIcon (bool isWriting) {
    emit(ChangedIcon(change: isWriting));
  }
}
