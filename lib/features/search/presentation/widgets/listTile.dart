

import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const CustomListTile({super.key,required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: onTap,
      title: Text(title,style: Theme.of(context).textTheme.displaySmall,),
      leading: CircleAvatar(
        backgroundColor: ColorsConsts.containerGreen,
        child: Icon(icon,color: ColorsConsts.whiteColor,),
      ),
    );
  }
}
