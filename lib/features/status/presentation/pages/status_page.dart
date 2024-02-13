

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(0.05.mediaW(context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status",style: Theme.of(context).textTheme.displayMedium,),
            ListTile(
              leading: const CircleAvatar(),
              title: Text("My Status",style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 0.05.mediaW(context)),),
              subtitle: Text("Tap to add status update",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.iconGrey),),
            ),
            0.05.sizeH(context),
            Text("Recent updates",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.iconGrey),),
            ListTile(
              leading: const CircleAvatar(),
              title: Text("Username",style: Theme.of(context).textTheme.displaySmall,),
              subtitle: Text("Timestamp",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorsConsts.iconGrey),),
            )
          ],
        ),
      ),
    );
  }
}
