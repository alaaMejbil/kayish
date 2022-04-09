import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/widgets/defualt_text.dart';

class DefaultButton extends StatelessWidget{
  double? height;
  double? width;
  VoidCallback? onPressed;
  String? text;
  Color? buttonColor;
  Color? textColor;
  Gradient? gradiant;
  Color? borderColor;
  DefaultButton({
    this.width=double.infinity,
    this.height=45,
    this.textColor=Colors.white,
    this.buttonColor=ColorManager.primary,
    required this.text,
    required this.onPressed,
    this.gradiant,
    this.borderColor=ColorManager.primary,


});


  @override
  Widget build(BuildContext context) {
   return Container(
     height: height,
     width: width,
     decoration: BoxDecoration(
       gradient: gradiant,
       border: Border.all(color: borderColor!),
       color: buttonColor!,
       borderRadius: BorderRadius.circular(25),
     ),
     child: MaterialButton(
       onPressed: onPressed,
       child: Text(
        AppLocalization.of(context).translate(text!)!,
         textAlign: TextAlign.center,
         textScaleFactor: .90,
         style:TextStyle(
           color: textColor,
           fontSize: 18,
           fontWeight: FontWeight.w800,
           fontFamily: "GE"

         ),


       ),
     ),
   );
  }

}