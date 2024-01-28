

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/widgets/agree_and_continue_button.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/widgets/dialog_loading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConsts.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  0.1.sizeH(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Enter your phone number",style: Theme.of(context).textTheme.displayMedium,),
                      0.04.sizeW(context),
                      Icon(Icons.more_vert,size: 0.05.mediaH(context),),
                    ],
                  ),
                  0.05.sizeH(context),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "WhatsApp Clone will need to verify your phone number. ",
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14)
                        ),
                        TextSpan(
                          text: "What's \n                                       my number?",
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14,color: Colors.blue),
                        ),
                      ]
                    ),
                  ),
                  0.05.sizeH(context),
                  SizedBox(
                    width: 0.6.mediaW(context),
                    child: const IntlPhoneField(
                      style: TextStyle(
                        color: ColorsConsts.whiteColor,
                      ),
                      dropdownTextStyle: TextStyle(
                        color: ColorsConsts.whiteColor,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsConsts.fieldGreenColor,
                          )
                        )
                      ),
                    ),
                  ),
                  Text("Carrier charges may apply",style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 13),),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                showDialog(
                    context: context, builder: (context){
                      return  Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.2.mediaW(context)),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DialogLoading(),
                            ],
                          ),
                        ),
                      );
                }
                );
                // TODO: move to  pin page
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                color: ColorsConsts.containerGreen,
                child: Text("Next",style: Theme.of(context).textTheme.displaySmall),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
