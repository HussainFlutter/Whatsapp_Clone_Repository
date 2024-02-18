import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/bloc/login_bloc.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/bloc/splash_screen_bloc.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/change_icon_cubit.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/chat_room_bloc.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/reply_cubit.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/show_emoji_picker_cubit.dart';
import 'package:whatsapp_clone_repository/features/search/presentation/bloc/search_bloc.dart';
import 'package:whatsapp_clone_repository/features/status/presentation/bloc/get_my_status_cubit.dart';
import 'package:whatsapp_clone_repository/features/status/presentation/bloc/status_bloc.dart';
import 'config/theme.dart';
import 'core/dependency_injection.dart';
import 'core/on_generate_routes.dart';
import 'features/chat_room/presentation/bloc/delete_appbar/delete_app_bar_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SplashScreenBloc>(),
        ),
        BlocProvider(
          create: (context) =>sl<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) =>sl<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) =>sl<ChangeIconCubit>(),
        ),
        BlocProvider(
          create: (context) =>sl<ChatRoomBloc>(),
        ),
        BlocProvider(
          create: (context) =>sl<ShowEmojiPickerCubit>(),
        ),
        BlocProvider(
          create: (context) =>sl<DeleteAppBarCubit>(),
        ),
        BlocProvider(
          create: (context) =>sl<StatusBloc>(),
        ),
        BlocProvider(
          create: (context) =>sl<GetMyStatusCubit>(),
        ),
        BlocProvider(
          create: (context) =>sl<ReplyCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whatsapp Clone',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            textTheme: textTheme(context),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
        ),

        onGenerateRoute: onGenerateRoute,
        initialRoute: RouteNames.splashPage,
      ),
    );
  }
}
