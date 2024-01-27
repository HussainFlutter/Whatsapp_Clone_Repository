

import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class WhatsAppIcon extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final double? iconHeight;
  final double? iconWidth;
  final double borderRadius;
  const WhatsAppIcon({
    super.key,
     this.iconWidth,
     this.iconHeight,
    required this.containerWidth,
    required this.containerHeight,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            color: ColorsConsts.greenColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        Image.asset(
          "assets/image_assets/whatsapp_icon.png",
          height: iconHeight,
          width: iconWidth,
        ),
      ],
    );
  }
}
