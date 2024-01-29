


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/widgets/agree_and_continue_button.dart';

class EnterPinPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const EnterPinPage({super.key,required this.phoneNumber, required this.verificationId});

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  int count = 60;
  String pinCode = "";
  void startTimer () {
     Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        count--;
      });
      if(count <= 0)
        {
          setState(() {
            timer.cancel();
          });
        }
    });
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConsts.backgroundColor,
        automaticallyImplyLeading: true,
        title: Text("Enter OTP Code",style: Theme.of(context).textTheme.displayMedium),
      ),
      backgroundColor: ColorsConsts.backgroundColor,
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 0.02.mediaW(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              0.04.sizeH(context),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Code has been send to ${widget.phoneNumber}",style: Theme.of(context).textTheme.displaySmall,),
                    0.07.sizeH(context),
                    //Pin Code
                    PinCodeTextField(
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldWidth: 0.12.mediaW(context),
                        fieldHeight: 0.07.mediaH(context),
                        activeColor: Colors.white,
                        errorBorderColor: Colors.white,
                        inactiveColor: Colors.white,
                        selectedColor: Colors.white,
                      ),
                      onCompleted: (value){
                        pinCode = value;
                      },
                      onChanged: (value){
                        pinCode = value;
                      },
                      textStyle: const TextStyle(
                        color: ColorsConsts.whiteColor,
                      ),
                      keyboardType: TextInputType.phone,
                      backgroundColor: Colors.transparent,
                        appContext: context,
                        length: 6,
                    ),
                    0.02.sizeH(context),
                    Text("Resend Code in $count s",style: Theme.of(context).textTheme.displaySmall,),
                    0.04.sizeH(context),
                    count == 0 ?
                        SizedBox(
                          width: 0.3.mediaW(context),
                          child: AgreeAndContinueButton(
                              onTap: (){},
                            title: "Resend",
                          ),
                        )
                        : const SizedBox(),
                  ],
                ),
              ),
              AgreeAndContinueButton(
                title: "Verify",
                onTap: (){
                  //TODO: implement verify login
                  print(pinCode);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
