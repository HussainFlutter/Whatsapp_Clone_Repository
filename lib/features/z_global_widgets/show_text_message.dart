

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';

class ShowTextMessage extends StatelessWidget {
  final String message;
  final Color textColor;
  const ShowTextMessage({
    super.key,
    required this.message,
    this.textColor = ColorsConsts.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(message,style: Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor),);
  }
}
