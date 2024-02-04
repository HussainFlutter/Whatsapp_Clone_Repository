

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';

import '../../../z_global_widgets/round_button.dart';

class NoChatsYet extends StatelessWidget {
  final UserEntity currentUser;
  const NoChatsYet({super.key,required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/image_assets/logo.png"),
          0.08.sizeH(context),
          Text("You haven't chat yet",style: Theme.of(context).textTheme.displayLarge,),
          0.05.sizeH(context),
          RoundButton(
            borderRadius: 50,
            fontWeight: FontWeight.bold,
            height: 0.06.mediaH(context),
            width: 0.4.mediaW(context),
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.searchPage,
                arguments: currentUser,
              );
            },
            title: "Start Chatting",
          ),
        ],
      ),
    );
  }
}
