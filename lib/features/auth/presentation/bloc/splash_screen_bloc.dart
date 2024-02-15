import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/is_login_usecase.dart';
import '../../../../core/dependency_injection.dart';
import '../../domain/usecase/get_current_user_uid_usecase.dart';
import '../../domain/usecase/get_single_user_usecase.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final IsLoginUseCase isLogin;
  final GetCurrentUserUidUseCase getUid;
  final GetSingleUserUseCase getSingleUser;
  SplashScreenBloc({required this.isLogin,required this.getUid,required this.getSingleUser}) : super(SplashScreenInitial()) {
    on<CheckUserEvent>((event, emit) => _checkUser(event));
    on<ResendCodeEvent>((event, emit) => _resendCode(event));
  }
  _checkUser (
      CheckUserEvent event,
      ) async {
    try{
      final result = await isLogin();
      // check if user is logged in or not
      result.fold((l) async {
        final bool isLoggedIn = l;
        if(isLoggedIn == true)
          {
            // Fetch user and navigate to Main Page
            final Completer<void> completer = Completer<void>();
            final result2 =  await getUid();
            result2.fold(
                  (l) async{
                    debugPrint("login bloc currentUser:$l");
                    final String uid = l!;
                    UserEntity currentUser = const UserEntity();
                    //fetching user
                    final stream = getSingleUser(UserEntity(uid: uid)).listen((event) {
                      event.fold((fetchedUser) {
                        debugPrint("login bloc currentUser:$fetchedUser");
                         currentUser = fetchedUser[0];
                         completer.complete();
                      }, (r) {
                        toast(message: r.toString());
                      });
                    },
                    onDone: ()=> completer.complete(),
                    onError: (e) => completer.complete(),
                    );
                    await completer.future;
                    if(event.context.mounted)
                      {
                        stream.cancel();
                       // print(currentUser);
                        Navigator.pushReplacementNamed(event.context, RouteNames.mainPage,
                            arguments: currentUser
                        );
                      }
                  },
                    (r) {
                      toast(message: r.toString());
                    },
            );
          }
        else
          {
            // Navigate to Agree to Terms and Condition Page
            if(event.context.mounted)
            {
              Navigator.pushReplacementNamed(event.context, RouteNames.agreeToTermsPage,);
            }
          }
      },
        (r)  {

        toast(message: r.toString());
      });
    }catch(e){
      toast(message: "Caught some error");
      debugPrint(e.toString());
    }
  }
  _resendCode (
      ResendCodeEvent event,
      ) async {
    await sl<FirebaseAuth>().verifyPhoneNumber(
    phoneNumber: event.phoneNumber,
    timeout: const Duration(seconds: 60),
    verificationCompleted: (e){},
    verificationFailed: (e){},
    codeSent: (verificationId,token){
      toast(message: "Code resent",backgroundColor: ColorsConsts.containerGreen);
    },
    codeAutoRetrievalTimeout: (e){},
    );
  }
}
