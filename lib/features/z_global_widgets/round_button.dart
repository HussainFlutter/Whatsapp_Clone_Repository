import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final double? height;
  final double? width;
  final double borderRadius;
  final FontWeight fontWeight;
  const RoundButton({
    super.key,
    required this.onTap,
    this.title = "AGREE AND CONTINUE",
    this.width,
    this.height,
    this.fontWeight = FontWeight.normal,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ??  0.04.mediaH(context),
        width: width ?? 0.7.mediaW(context),
        decoration: BoxDecoration(
          color: ColorsConsts.greenColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child:Center(child: Text(title,style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight:fontWeight ),)),
      ),
    );
  }
}
