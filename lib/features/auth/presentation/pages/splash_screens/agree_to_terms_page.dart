


import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

import '../../widgets/accept_terms_policy.dart';
import '../../widgets/agree_and_continue_button.dart';

class AgreeToTermsPage extends StatefulWidget {
  const AgreeToTermsPage({super.key});

  @override
  State<AgreeToTermsPage> createState() => _AgreeToTermsPageState();
}

class _AgreeToTermsPageState extends State<AgreeToTermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            0.2.sizeH(context),
            Image.asset(
              "assets/image_assets/agree.png"
            ),
            0.05.sizeH(context),
            const AcceptTermsAndConditions(),
            0.04.sizeH(context),
            AgreeAndContinueButton(
              onTap: (){

              },
            ),
            Column(
              children: [
                0.2.sizeH(context),
                Text("from",style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 13,color: Colors.grey.withOpacity(0.4)),),
                Text("FACEBOOK",style: Theme.of(context).textTheme.displaySmall!.copyWith(letterSpacing: 2),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
