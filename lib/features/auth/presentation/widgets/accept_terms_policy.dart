

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AcceptTermsAndConditions extends StatelessWidget {
  const AcceptTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
              children:[
                const TextSpan(
                    text: "Read our "
                ),
                TextSpan(
                  text: "Privacy Policy",
                  recognizer: TapGestureRecognizer()..onTap = () {
                    debugPrint("Navigate to Privacy Policy");
                  },
                  style: const TextStyle(
                      color: Colors.blue
                  ),
                ),
                const TextSpan(
                    text: "Tap 'Agree and continue' to \n                    accept the"
                ),
                TextSpan(
                  text: "Terms of Service",
                  recognizer: TapGestureRecognizer()..onTap = () {
                    debugPrint("Navigate to terms and service");
                  },
                  style: const TextStyle(
                      color: Colors.blue
                  ),
                ),
              ]
          ),
        )
      ],
    );
  }
}
