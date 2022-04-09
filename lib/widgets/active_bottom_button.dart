import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class ActiveButton extends StatelessWidget {
  String? icon;
  String? label;
  ActiveButton({
    required this.icon,
    required this.label,
});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.circular(20),

      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8,vertical: 8),
        child: Row(
          children: [

            Image(
              height: 20,
              width: 20,
              image: AssetImage(icon!)
              ,color: Colors.white,

            ),
            const SizedBox(width: 4,),
            Text(
              AppLocalization.of(context).translate(label!)!,
              style:const TextStyle(
                fontFamily: 'GE',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
