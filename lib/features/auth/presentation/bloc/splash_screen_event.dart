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
