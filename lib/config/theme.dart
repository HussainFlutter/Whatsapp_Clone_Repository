
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

TextTheme textTheme (BuildContext context) {
  return  TextTheme(
    displayLarge: TextStyle(
      fontSize: 0.044.mediaH(context),
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
    displayMedium: TextStyle(
      fontSize: 0.03.mediaH(context),
        color: Colors.white
    ),
    displaySmall: TextStyle(
        fontSize: 0.018.mediaH(context),
        color: Colors.white,
    ),
  );
}