


import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

import '../../core/constants.dart';

class TabBarWidget extends StatelessWidget implements PreferredSize {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelColor: ColorsConsts.whiteColor,
      labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
      indicatorColor: ColorsConsts.whiteColor,
      indicator: const UnderlineTabIndicator(),
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: ColorsConsts.whiteColor,
      indicatorPadding: EdgeInsets.symmetric(horizontal: 0.05.mediaW(context)),
      tabs:  [
        SizedBox(width: 0.06.mediaW(context),child: const Tab(icon: Icon(Icons.camera_alt),)),
        SizedBox(width: 0.2.mediaW(context),child: const Tab(text: 'CHATS')),
        SizedBox(width: 0.2.mediaW(context),child: const Tab(text: 'STATUS')),
        SizedBox(width: 0.2.mediaW(context),child: const Tab(text: 'CALLS')),
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
