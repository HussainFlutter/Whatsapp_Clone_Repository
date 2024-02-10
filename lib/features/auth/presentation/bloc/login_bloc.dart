import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/change_presence_use_case.dart';

import '../../../../core/dependency_injection.dart';
import '../../domain/usecase/create_user_usecase.dart';
import '../../domain/usecase/get_current_user_uid_usecase.dart';
import '../../domain/usecase/get_single_user_usecase.dart';
import '../../domain/usecase/log_out_use_case.dart';
import '../../domain/usecase/sign_up_using_phone_number_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetSingleUserUseCase getSingleUser;
  final SignUpUsingPhoneNumberUseCase signUp;
  final GetCurrentUserUidUseCase getUid;
  final LogOutUseCase logOut;
  final ChangePresenceUseCase changePresence;
  final CreateUserUseCase createUser;
  LoginBloc({
    required this.logOut,
    required this.getSingleUser,
    required this.signUp,
    required this.getUid,
    required this.createUser,
    required this.changePresence,
  }) : super(LoginInitial()) {
    on<LoginUserEvent>((event, emit) => _sendCode(event));
    on<Login>((event, emit) => _login(event));
    on<LogOutEvent>((event, emit) => _logOut(event));
    on<ChangePresenceEvent>((event, emit) => _changePresence(event));
  }

  _sendCode (
      LoginUserEvent event,
      ) async {
    // sending code
    await sl<FirebaseAuth>().verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (e){},
        verificationFailed: (e){},
        codeSent: (verificationId,token){
          // navigating to pin code page
          Map<String,dynamic> args = {
            "phoneNumber" : event.phoneNumber,
            "verificationId" : verificationId,
          };
              Navigator.pop(event.context);
              Navigator.pushNamed(
                  event.context, RouteNames.pinPage,
                  arguments: args,
              );
            },
        codeAutoRetrievalTimeout: (e){},
    );
  }

  _login (
      Login event,
      )
  async
  {
    try{
      final signUpResult  = await signUp(event.verificationId,event.smsCode);
      signUpResult.fold(
              (l) async {
                final result = await getUid();
                result.fold((uid) {
                  getSingleUser(UserEntity(uid: uid)).listen((user) {
                    user.fold((l) {
                      // fetched user
                      Navigator.pushReplacementNamed(
                        event.context,
                        RouteNames.mainPage,
                        arguments: l[0],
                      );
                    }, (r) async {
                      // if no user create one
                      await createUser(
                        UserEntity(
                            name: event.phoneNumber,
                            uid: uid,
                            about: "Hey, I'm Using WhatsApp Clone!",
                            phoneNumber: event.phoneNumber,
                            presence: false,
                            createAt: DateTime.now()
                        ),
                      );
                    });
                  });
                }, (r) {
                  toast(message: r.message!);
                });
              },
              (r) {
                toast(message: "Provided code does not match");
              });

    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  _logOut (
      LogOutEvent event,
      ) async{
    try{
      await logOut();
      if(event.context.mounted)
        {
          Navigator.popUntil(event.context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(event.context, RouteNames.loginPage);
        }
    }catch(e)
    {
      rethrow;
    }
  }

  _changePresence (
      ChangePresenceEvent event,
      ) async {
    await changePresence(UserEntity(uid: event.uid),event.presence);
  }

}
