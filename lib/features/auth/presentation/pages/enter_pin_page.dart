


import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/constants.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';
import 'package:whatsapp_clone_repository/features/auth/presentation/widgets/agree_and_continue_button.dart';

class EnterPinPage extends StatefulWidget {
  final String phoneNumber;
  const EnterPinPage({super.key,required this.phoneNumber});

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                      height: 0.1.mediaH(context),
                      width: 0.12.mediaW(context),
                      child: TextFormField(
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                      ),
                    ),
                      SizedBox(
                        height: 0.1.mediaH(context),
                        width: 0.12.mediaW(context),
                        child: TextFormField(
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.1.mediaH(context),
                        width: 0.12.mediaW(context),
                        child: TextFormField(
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.1.mediaH(context),
                        width: 0.12.mediaW(context),
                        child: TextFormField(
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.1.mediaH(context),
                        width: 0.12.mediaW(context),
                        child: TextFormField(
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.1.mediaH(context),
                        width: 0.12.mediaW(context),
                        child: TextFormField(
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ),
                      ),
                  ],
                  ),
                  Text("Reset Code in 23 s",style: Theme.of(context).textTheme.displaySmall,),
                ],
              ),
            ),
            AgreeAndContinueButton(
              title: "Verify",
              onTap: (){
                // TODO: verify pin and reset pin code
              },
            ),
          ],
        ),
      ),
    );
  }
}
