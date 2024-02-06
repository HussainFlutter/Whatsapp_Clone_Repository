

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_repository/core/utils.dart';

import '../../../../core/constants.dart';

class ChatRoomTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String?) onChanged;
  const ChatRoomTextField({super.key,required this.controller,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      style: Theme.of(context).textTheme.displaySmall,
      decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: SizedBox(
            width: 0.18.mediaW(context),
            child: Row(
              children: [
                Transform.rotate(
                    angle: 4,
                    child: const Icon(Icons.attachment)),
                0.02.sizeW(context),
                const Icon(Icons.camera_alt),
              ],
            ),
          ),
          suffixIconColor: ColorsConsts.iconGrey,
          prefixIconColor: ColorsConsts.iconGrey,
          prefixIcon: const Icon(Icons.emoji_emotions),
          hintStyle: const TextStyle(
            color: ColorsConsts.iconGrey,
          ),
          hintText: "Message"
      ),
      onChanged: onChanged,
      // onChanged: (e){
      //   if(messageController.text.isEmpty || messageController.text == "")
      //   {
      //     setState(() {
      //       isWriting = false;
      //     });
      //   }
      //   else
      //   {
      //     setState(() {
      //       isWriting = true;
      //     });
      //   }
      // },
    );

  }
}
