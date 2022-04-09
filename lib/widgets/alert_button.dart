import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertButton extends StatelessWidget {
  String text;
  VoidCallback? onPressed;
  AlertButton({
    required this.text,
    required this.onPressed
});

  @override
  Widget build(BuildContext context) {
    return  DialogButton(
      child: Container(

        child: Text(
          AppLocalization.of(context).translate('Later')!,
          style:  Styles.getBoldMainTextStyle(color:ColorManager.primary,fontSize: FontSize.s18),
        ),

      ),
      onPressed: (){

      },
      radius: BorderRadius.circular(25),
      height: 50,
      color: Colors.white,
      border: Border.all(color: ColorManager.primary),
    );
  }
}
