 import 'package:flutter/cupertino.dart';
import 'package:kayish/shared/component/font_manager.dart';
class Styles{
 static TextStyle _getTextStyle({
    double? fontSize,String? fontFamily,FontWeight? fontWeight,Color? color
  }){
    return TextStyle(

        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight
    );
  }

 static TextStyle getLightMainTextStyle({double fontSize=FontSize.s14,required Color? color}){
    return _getTextStyle(
      fontWeight: FontWeightManager.light,
      fontFamily: FontConstants.mainFont,
      color: color,
      fontSize: fontSize,
    );
  }
 static TextStyle getMidMainTextStyle({double fontSize=FontSize.s14,required Color? color}){
    return _getTextStyle(
      fontWeight: FontWeightManager.mid,
      fontFamily: FontConstants.mainFont,
      color: color,
      fontSize: fontSize,
    );
  }
 static TextStyle getBoldMainTextStyle({double fontSize=FontSize.s14,required Color? color}){
    return _getTextStyle(
      fontWeight:FontWeight.w800,
      fontFamily: FontConstants.mainFont,
      color: color,
      fontSize: fontSize,
    );
  }


 static TextStyle getLightSecondryTextStyle({double fontSize=FontSize.s14,required Color? color}){
    return _getTextStyle(
      fontWeight: FontWeightManager.light,
      fontFamily: FontConstants.seconderyFont,
      color: color,
      fontSize: fontSize,
    );
  }
 static TextStyle getMidSecondryTextStyle({double fontSize=FontSize.s14,required Color? color}){
    return _getTextStyle(
      fontWeight: FontWeightManager.light,
      fontFamily: FontConstants.seconderyFont,
      color: color,
      fontSize: fontSize,
    );
  }
 static TextStyle getBoldSecondryTextStyle({double fontSize=FontSize.s14,required Color? color}){
    return _getTextStyle(
      fontWeight: FontWeightManager.light,
      fontFamily: FontConstants.seconderyFont,
      color: color,
      fontSize: fontSize,
    );
  }
}
