part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent {
  final String phoneNumber;
  final BuildContext context;

  const LoginUserEvent({required this.phoneNumber, required this.context});
  @override
  List<Object?> get props => [context,phoneNumber];

}

class Login extends LoginEvent {
  final String verificationId;
  final String smsCode;
  final BuildContext context;
  final String phoneNumber;
  const Login({
    required this.smsCode,
    required this.context,
    required this.verificationId,
    required this.phoneNumber,
  });
  @override
  List<Object?> get props => [verificationId,smsCode,context,phoneNumber];
}

class LogOutEvent extends LoginEvent{
  final BuildContext context;

  const LogOutEvent({required this.context});
  @override
  List<Object?> get props => [context];

}

class ChangePresenceEvent extends LoginEvent {
  final String uid;
  final bool presence;

  const ChangePresenceEvent({required this.uid, required this.presence});

  @override
  List<Object?> get props => [uid,presence];
}