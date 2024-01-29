import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';

import '../../../../core/dependency_injection.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>((event, emit) => _sendCode(event));
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
        //  if(event.context.mounted)
         //   {
              Navigator.pop(event.context);
              Navigator.pushNamed(
                  event.context, RouteNames.pinPage,
                  arguments: args,
              );
            //}
            },
        codeAutoRetrievalTimeout: (e){},
    );
  }

}
