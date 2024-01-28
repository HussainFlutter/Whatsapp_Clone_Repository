
import 'package:flutter/material.dart';

TextTheme textTheme () {
  return const TextTheme(
    displayLarge: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
    displayMedium: TextStyle(
      fontSize: 24,
        color: Colors.white
    ),
    displaySmall: TextStyle(
        fontSize: 16,
        color: Colors.white,
    ),
  );
}