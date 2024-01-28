

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/features/auth/domain/entity/user_entity.dart';

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
      body: Center(
        child: Text(
          "Main Page ${widget.currentUser.name}"
        ),
      ),
    );
  }
}
