import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/usecase/is_login_usecase.dart';
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
                    final String uid = l!;
                    UserEntity currentUser = const UserEntity();
                    //fetching user
                    final stream = getSingleUser(UserEntity(uid: uid)).listen((event) {
                      event.fold((fetchedUser) {
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
}
