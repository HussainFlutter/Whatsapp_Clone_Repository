


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/z_global_widgets/round_button.dart';

import '../bloc/login_bloc.dart';
import '../bloc/splash_screen_bloc.dart';

class EnterPinPage extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const EnterPinPage({super.key,required this.phoneNumber, required this.verificationId});

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  int count = 60;
  late Timer timer;
  String pinCode = "";
  void startTimer () {
     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
  void dispose() {
    super.dispose();
    timer.cancel();
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
                          child: RoundButton(
                              onTap: (){
                                context.read<SplashScreenBloc>().add(ResendCodeEvent(phoneNumber: widget.phoneNumber));
                                setState(() {
                                  count = 60;
                                });
                              },
                            title: "Resend",
                          ),
                        )
                        : const SizedBox(),
                  ],
                ),
              ),
              RoundButton(
                title: "Verify",
                onTap: (){
                  debugPrint(pinCode);
                  debugPrint(pinCode.length.toString());
                if(pinCode.length == 6)
                  {
                    context.read<LoginBloc>().add(
                        Login(
                          smsCode: pinCode,
                          context: context,
                          verificationId: widget.verificationId,
                          phoneNumber: widget.phoneNumber,
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
