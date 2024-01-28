
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/widgets/whatsapp_icon.dart';

class SplashPage2 extends StatefulWidget {
  const SplashPage2({super.key});

  @override
  State<SplashPage2> createState() => _SplashPage2State();
}

class _SplashPage2State extends State<SplashPage2> {
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
                WhatsAppIcon(
                    iconWidth: 0.08.mediaW(context),
                    iconHeight: 0.08.mediaH(context),
                    containerWidth: 0.13.mediaW(context),
                    containerHeight: 0.056.mediaH(context),
                    borderRadius: 10,
                ),
                Text("WhatsApp",style: Theme.of(context).textTheme.displayLarge,),
                0.2.sizeH(context),
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
            bottom: 0.05.mediaH(context),
            right: 0.4.mediaW(context),
            child: Column(
              children: [
                Text("from",style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 13,color: Colors.grey.withOpacity(0.4)),),
                Text("FACEBOOK",style: Theme.of(context).textTheme.displaySmall!.copyWith(letterSpacing: 2),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
