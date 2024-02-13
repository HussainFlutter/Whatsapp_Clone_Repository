import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';
import 'package:whatsapp_clone_repository/features/status/presentation/pages/status_page.dart';
import 'auth/presentation/bloc/login_bloc.dart';
import 'chats/presentation/pages/chat_page.dart';
import 'z_global_widgets/tabBar_widget.dart';

class MainPage extends StatefulWidget {
  final UserEntity currentUser;
  const MainPage({super.key, required this.currentUser});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    // Changing presence according to our users presence
    context.read<LoginBloc>().add(
        ChangePresenceEvent(uid: widget.currentUser.uid!, presence: true));
    AppLifecycleListener(
      onResume: (){
        debugPrint("resumed");
        context.read<LoginBloc>().add(
            ChangePresenceEvent(uid: widget.currentUser.uid!, presence: true));
      },
      onPause: (){
      debugPrint("paused");
      context.read<LoginBloc>().add(
          ChangePresenceEvent(uid: widget.currentUser.uid!, presence: false));
    },
      onInactive: (){
        debugPrint("inactive");
        context.read<LoginBloc>().add(
            ChangePresenceEvent(uid: widget.currentUser.uid!, presence: false));
      },
      onDetach: (){
      debugPrint("detached");
      context.read<LoginBloc>().add(
          ChangePresenceEvent(uid: widget.currentUser.uid!, presence: false));
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      ChatsPage(
        currentUser: widget.currentUser,
      ),
      ChatsPage(
        currentUser: widget.currentUser,
      ),
      const StatusPage(),
      ChatsPage(
        currentUser: widget.currentUser,
      ),
    ];
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "WhatsApp",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: ColorsConsts.appbarGreen,
          actionsIconTheme: const IconThemeData(
            color: ColorsConsts.whiteColor,
          ),
          actions: [
            InkWell(
                onTap: () {},
                child: Image.asset("assets/image_assets/Search.png")),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(child: Text("Settings")),
                  PopupMenuItem(
                      onTap: () {
                        context
                            .read<LoginBloc>()
                            .add(LogOutEvent(context: context));
                      },
                      child: const Text("Log Out")),
                ];
              },
            ),
          ],
          bottom: const TabBarWidget(),
        ),
        body: TabBarView(
          children: tabs,
        ),
      ),
    );
  }
}
