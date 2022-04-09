import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/modules/account_verfication_screen.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'navigate_functions.dart';

class MyAlert{
  static myAlert({required BuildContext context,required title,String? assetImage,List<DialogButton>? buttons}){
    Alert(
        context: context,
        image: Image(
          height: 40,
          width: 40,
          image: AssetImage(assetImage!),
        ),
        title: AppLocalization.of(context).translate(title),

        style:AlertStyle(
          buttonsDirection: ButtonsDirection.column,
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titleStyle:Styles.getMidMainTextStyle(color: Colors.grey.shade600,fontSize: FontSize.s16),

        ),
        buttons: buttons
    ).show();
  }
}