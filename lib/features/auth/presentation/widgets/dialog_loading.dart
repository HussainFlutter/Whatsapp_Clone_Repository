

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

import '../../../../core/constants.dart';

class DialogLoading extends StatelessWidget {
  const DialogLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsConsts.backgroundColor,
      content: Center(
        child: SizedBox(
              child: CircularProgressIndicator(
                backgroundColor: ColorsConsts.loadingColor.withOpacity(0.3),
                color: ColorsConsts.loadingColor,
                strokeWidth: 6,
              ),
              height: 0.12.mediaH(context),
              width: 0.25.mediaW(context),
            ),

      ),
    );
  }
}
