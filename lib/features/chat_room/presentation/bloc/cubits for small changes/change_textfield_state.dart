part of 'change_textfield_cubit.dart';

class ChangeTextFieldState extends Equatable {
  final bool isRecording;
  const ChangeTextFieldState({required this.isRecording});
  @override
  List<Object?> get props => [isRecording];
}

