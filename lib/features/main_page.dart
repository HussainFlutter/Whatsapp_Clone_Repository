import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';

import 'auth/presentation/bloc/login_bloc.dart';
import 'home/presentation/pages/home_page.dart';
import 'home/presentation/widgets/tabBar_widget.dart';

class MainPage extends StatefulWidget {
  final UserEntity currentUser;
  const MainPage({super.key, required this.currentUser});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _tabs = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text("WhatsApp",style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),),
          backgroundColor: ColorsConsts.appbarGreen,
          actionsIconTheme: const IconThemeData(
          color: ColorsConsts.whiteColor,
          ),
          actions: [
            InkWell(
                onTap: (){

                },
                child: Image.asset("assets/image_assets/Search.png")),
                  PopupMenuButton(
                    itemBuilder: (context){
                      return [
                        const PopupMenuItem(child: Text("Settings")),
                         PopupMenuItem(
                             onTap: (){
                               context.read<LoginBloc>().add(LogOutEvent(context: context));
                             }
                             ,child: const Text("Log Out")),
                      ];
                    },
                  ),

          ],
          bottom: const TabBarWidget(),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}
