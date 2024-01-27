
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/widgets/whatsapp_icon.dart';

class SplashPage3 extends StatefulWidget {
  const SplashPage3({super.key});

  @override
  State<SplashPage3> createState() => _SplashPage3State();
}

class _SplashPage3State extends State<SplashPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WhatsAppIcon(
                      iconWidth: 0.1.mediaW(context),
                      iconHeight: 0.1.mediaH(context),
                      containerWidth: 0.15.mediaW(context),
                      containerHeight: 0.07.mediaH(context),
                      borderRadius: 10,
                    ),
                    SizedBox(height: 0.04.mediaH(context),),
                    Text("WhatsApp",style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 42),),
                    SizedBox(height: 0.15.mediaH(context),),
                  ],
                ),
              ],
            ),
          ),
          // Vectors
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
          Positioned(
            right: 0.38.mediaW(context),
            bottom: 0.1.mediaH(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: ColorsConsts.greenColor.withOpacity(0.3),
                  color: ColorsConsts.greenColor,
                  strokeWidth: 5,
                ),
                0.02.sizeH(context),
                Text("Loading...",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: ColorsConsts.greenColor),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
