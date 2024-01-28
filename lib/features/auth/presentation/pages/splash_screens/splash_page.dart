
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/widgets/whatsapp_icon.dart';

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
      body: Stack(
        children: [
          Center(child: WhatsAppIcon(containerWidth: 0.32.mediaW(context), containerHeight: 0.14.mediaH(context))),
          Positioned(
            bottom: 0.1.mediaH(context),
              child: Image.asset("assets/image_assets/vector1.png")
          ),
          Positioned(
              left: 0.1.mediaW(context),
              top: 0.35.mediaH(context),
              child: Image.asset("assets/image_assets/vector2.png")
          ),
          Positioned(
              top: 0.08.mediaH(context),
              child: Image.asset("assets/image_assets/vector3.png")
          ),
          Positioned(
              bottom: 0.3.mediaH(context),
              right: 0.1.mediaW(context),
              child: Image.asset("assets/image_assets/vector4.png")
          ),
          Positioned(
              top: 0.13.mediaH(context),
              right: 0,
              child: Image.asset("assets/image_assets/vector5.png")
          ),
        ],
      ),
    );
  }
}
