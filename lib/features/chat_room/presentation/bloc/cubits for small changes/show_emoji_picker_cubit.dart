import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'show_emoji_picker_state.dart';

class ShowEmojiPickerCubit extends Cubit<ShowEmojiPickerState> {
  ShowEmojiPickerCubit() : super(const ShowEmojiPickerState(emojiToggle: false));
  void toggleEmojiPicker ({bool? changeEmoji}) {
    emit(ShowEmojiPickerState(emojiToggle: changeEmoji ?? !state.emojiToggle));
  }
}
