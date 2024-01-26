
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      body: Center(
        child: Container(
          height: 0.14.mediaH(context),
          width: 0.3.mediaW(context),
          color: ColorsConsts.greenColor,
          child: const SvgPicture(
            SvgAssetLoader(
                "assets/image_assets/whatsapp_icon.svg",
              theme: SvgTheme(
                currentColor: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}
