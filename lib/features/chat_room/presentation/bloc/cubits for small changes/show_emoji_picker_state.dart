part of 'show_emoji_picker_cubit.dart';

 class ShowEmojiPickerState extends Equatable {
  final bool emojiToggle;
  const ShowEmojiPickerState({required this.emojiToggle});

  @override
  List<Object?> get props => [emojiToggle];
}
