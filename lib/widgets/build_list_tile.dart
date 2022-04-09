import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class BuildListTile extends StatelessWidget {
  IconData? icon;
  String? title;
  GestureTapCallback? onTap;
  BuildListTile({
    required this.icon,
    required this.title,
    required this.onTap
});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: ListTile(

        leading: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Icon(icon,size: 18,color: Colors.black,),
        ),
        minLeadingWidth: 0,
        horizontalTitleGap: 8,
        contentPadding: EdgeInsetsDirectional.only(start: 26,end: 26),
        title: Text(
          AppLocalization.of(context).translate(title!)!,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: 'GE',
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
