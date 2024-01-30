

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';

import 'auth/presentation/bloc/login_bloc.dart';

class MainPage extends StatefulWidget {
  final UserEntity currentUser;
  const MainPage({super.key,required this.currentUser});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            context.read<LoginBloc>().add(LogOutEvent(context: context));
          }, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Text(
          "Main Page ${widget.currentUser.name}"
        ),
      ),
    );
  }
}
