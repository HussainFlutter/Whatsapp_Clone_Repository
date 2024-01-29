part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent {
  final String phoneNumber;
  final BuildContext context;

  const LoginUserEvent({required this.phoneNumber, required this.context});
  @override
  List<Object?> get props => [];

}
