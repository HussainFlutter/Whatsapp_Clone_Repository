

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/z_global_widgets/show_text_message.dart';
class HelloAnimation extends StatefulWidget {
  const HelloAnimation({super.key});

  @override
  State<HelloAnimation> createState() => _HelloAnimationState();
}

class _HelloAnimationState extends State<HelloAnimation> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<Offset> shakeAnimation;
  bool _isDisposed = false;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
    scaleAnimation = Tween<double>(begin: 5,end: 5.5).animate(controller);
    controller.forward();
    //shakeAnimation = Tween<Offset>(begin: const Offset(0,0),end: const Offset(100,20)).animate(controller);
    controller.addStatusListener((status) async {
      if(status == AnimationStatus.completed)
        {
          if (_isDisposed == false) {
           await Future.delayed(const Duration(seconds: 2));
           if(mounted)
             {
               controller.reset();
               controller.forward();
             }

          }
          else
            {
              controller.removeStatusListener((status) { });
              controller.removeListener(() { });
            }
        }
    });
  }
  Vector3 _shake() {
    double progress = controller.value;
    double offset = sin(progress * pi * 4);  // change 10 to make it vibrate faster
    return Vector3(offset * 5, 0.0, 0.0);  // change 25 to make it vibrate wider
  }

  shake() {
    controller.forward(from:0);
  }


  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ShowTextMessage(message: "Say Hello!"),
        0.05.sizeH(context),
        AnimatedBuilder(
          animation: controller,
          builder: (context,s){
            return Transform(
              transform: Matrix4.translation(_shake()),
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Transform.rotate(
                  angle: 0.4,
                  child: const Text("🤚",style: TextStyle(
                  ),),
                ),
              ),
            );
        },
        ),
      ],
    );
  }
}
