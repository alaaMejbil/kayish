import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';

class NotificationSettingS extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).translate('Notifications Settings')!,style: appBarTitle,),
        centerTitle: true,
        elevation: 0.0,
        leading:IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),

      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 32,left: 22,right: 22),
          child: Row(


            children: [
              Text(
                AppLocalization.of(context).translate('App Notifications')!,
                style: Styles.getMidMainTextStyle(color: Colors.black,fontSize: FontSize.s18),
                textAlign: TextAlign.center,
              ),
              Spacer(),

              Container(
                height: 30,
                width: 50,
                child: CupertinoSwitch(

                  value: true,
                  onChanged: (value){

                  },
                  activeColor: ColorManager.primary,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
