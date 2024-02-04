import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/custom_page_transition.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/pages/enter_pin_page.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/pages/login_page.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/pages/splash_screens/agree_to_terms_page.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/pages/splash_screens/splash_page.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/pages/chat_room_page.dart';
import 'package:whatsapp_clone_repository/features/main_page.dart';
import 'package:whatsapp_clone_repository/features/search/domain/entity/chat_room_entity.dart';
import 'package:whatsapp_clone_repository/features/search/presentation/pages/search_page.dart';
import '../features/auth/presentation/pages/splash_screens/splash_page_2.dart';
import '../features/auth/presentation/pages/splash_screens/splash_page_3.dart';

Route onGenerateRoute (RouteSettings settings) {
  switch(settings.name)
  {
    case RouteNames.chatRoomPage:
      final args =  settings.arguments  as Map<String ,dynamic>;
      UserEntity currentUser = args["currentUser"];
      UserEntity  targetUser = args["targetUser"];
      ChatRoomEntity chatRoomEntity = args["chatRoomEntity"];
      return CustomPageTransition(child: ChatRoomPage(currentUser: currentUser,targetUser: targetUser,chatRoomEntity: chatRoomEntity,));
    case RouteNames.splashPage:
        return CustomPageTransition(child: const SplashPage());
    case RouteNames.splashPage2:
      return CustomPageTransition(child: const  SplashPage2());
    case RouteNames.splashPage3:
      return CustomPageTransition(child: const SplashPage3());
    case RouteNames.agreeToTermsPage:
      return CustomPageTransition(child: const AgreeToTermsPage());
    case RouteNames.searchPage:
      return CustomPageTransition(child: SearchPage(currentUser: settings.arguments as UserEntity,));
    case RouteNames.loginPage:
      return CustomPageTransition(child: const LoginPage());
    case RouteNames.pinPage:
      final args =  settings.arguments  as Map<String ,dynamic>;
      String phoneNumber = args["phoneNumber"];
      String verificationId = args["verificationId"];
      return CustomPageTransition(child: EnterPinPage(phoneNumber: phoneNumber, verificationId: verificationId));
    case RouteNames.mainPage:
      return CustomPageTransition(child: MainPage(currentUser: settings.arguments as UserEntity,));
    default:
      return MaterialPageRoute(builder: (context) => const NoPageFound());
  }

}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("No Page Found")),
    );
  }
}
