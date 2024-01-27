import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

class AgreeAndContinueButton extends StatelessWidget {
  final VoidCallback onTap;
  const AgreeAndContinueButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 0.04.mediaH(context),
        width: 0.7.mediaW(context),
        decoration: BoxDecoration(
          color: ColorsConsts.greenColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(child: Text("AGREE AND CONTINUE")),
      ),
    );
  }
}
