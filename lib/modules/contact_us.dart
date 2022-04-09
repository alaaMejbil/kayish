import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

import 'layout_screen.dart';

class ContactUs extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).translate('Contact Us')!,style: appBarTitle),
        centerTitle: true,
        elevation: 0.0,
        leading:IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
            HomeCubit.get(context).getHomeData(cityId: 0,regionId: 0,districtId: 0,realStateTypeId: 0);
          },
        ),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),

      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalization.of(context).translate('Mobile number')!,
                  style:Styles.getBoldSecondryTextStyle(color: Colors.black,fontSize: FontSize.s18),

                ),
                Text('0512354687',
                  style:Styles.getBoldSecondryTextStyle(color: Colors.black,fontSize: FontSize.s18),

                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalization.of(context).translate('Email address',)!,
                  style:Styles.getBoldSecondryTextStyle(color: Colors.black,fontSize: FontSize.s18),

                ),
                Text('shatarh@gmail.com',
                  style:Styles.getBoldSecondryTextStyle(color: Colors.black,fontSize: FontSize.s18),

                ),
              ],
            ),
          ),
        ],
      ) ,
    );
  }
}
