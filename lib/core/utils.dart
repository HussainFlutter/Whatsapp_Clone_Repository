

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Media Query height and width extension

extension MediaHeight on double {
  double mediaH (BuildContext context) {
    return MediaQuery.of(context).size.height * this;
  }
}

extension MediaWidth on double {
  double mediaW (BuildContext context) {
    return MediaQuery.of(context).size.width * this;
  }
}

// SizedBox extension

extension SizeVertical on double {
  Widget sizeH (BuildContext context) {
    return SizedBox(height: mediaH(context), );
  }
}

extension SizeHorizontal on double {
  Widget sizeW (BuildContext context) {
    return SizedBox(width: mediaW(context), );
  }
}

void toast ({
  required String message,
  Color backgroundColor = Colors.red,
  Color textColor = Colors.white,
  double fontSize = 16.0,
  int duration = 2,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: duration,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize:fontSize,
  );
}

void customPrint ({required String message}) {
  debugPrint("----------------- DEBUG PRINT START ----------------");
  debugPrint("----------------------------------------------------");
  debugPrint("----------------------------------------------------");
  debugPrint(message);
  debugPrint("----------------------------------------------------");
  debugPrint("----------------------------------------------------");
  debugPrint("----------------- DEBUG PRINT END ------------------");
}