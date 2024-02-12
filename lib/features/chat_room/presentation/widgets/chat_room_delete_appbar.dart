
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/features/chat_room/domain/entity/message_entity.dart';
import 'package:whatsapp_clone_repository/features/chat_room/presentation/bloc/delete_appbar/delete_app_bar_cubit.dart';
import '../../../../core/constants.dart';

class ChatRoomDeleteAppBar extends StatelessWidget implements PreferredSize {
  final String chatRoomId;
  final int numberOfMessages;
  const ChatRoomDeleteAppBar({super.key,required this.chatRoomId, required this.numberOfMessages});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: ColorsConsts.whiteColor,
      ),
      automaticallyImplyLeading: false,
      backgroundColor: ColorsConsts.containerGreen,
      title: Text(numberOfMessages.toString(),style: Theme.of(context).textTheme.displaySmall,),
      leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){
        context.read<DeleteAppBarCubit>().changeSelected(selected: false,clear: true);
      },),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.reply)),
        IconButton(onPressed: (){
          context.read<DeleteAppBarCubit>().deleteMessages(context,chatRoomId);
        }, icon: const Icon(Icons.delete)),
        IconButton(onPressed: (){}, icon: const Icon(Icons.pin_drop)),
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
