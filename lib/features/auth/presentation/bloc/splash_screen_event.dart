part of 'splash_screen_bloc.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();
  @override
  List<Object?> get props => [];
}

class CheckUserEvent  extends SplashScreenEvent{
  final BuildContext context;

  const CheckUserEvent({required this.context});
  @override
  List<Object?> get props => [context];

}
class ResendCodeEvent  extends SplashScreenEvent{
  final String phoneNumber;

  const ResendCodeEvent({required this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];

}
