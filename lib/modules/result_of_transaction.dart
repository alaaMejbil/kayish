

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/default_button.dart';

class ResultOfTransactionScreen extends StatelessWidget {
  int? state;
  ResultOfTransactionScreen({
    this.state
});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).translate('Result of the transaction')!,style: appBarTitle,),
        centerTitle: true,
        elevation: 0.0,
        leading:IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
           navigateTo(context: context,nextScreen: LayoutScreen(pageNumber: 1,));
           HomeCubit.get(context).getHomeData(realStateTypeId: 0,districtId: 0,regionId: 0,cityId: 0);
          },
        ),

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child:state==null?
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Image(
                  height: 150,
                  width: 150,
                  image: AssetImage('icons/clock.png'),
                ),
                const SizedBox(height: 16,),
                Text(

                  AppLocalization.of(context).translate('Your request is in progress')!,
                  textAlign: TextAlign.center,
                  style:Styles.getMidMainTextStyle(color: ColorManager.primary,fontSize: FontSize.s22),
                ),

              ],
            ),



          ),
        ):
        state==2?
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Image(
                  height: 150,
                  width: 150,
                  image: AssetImage('icons/done.png'),
                ),
                const SizedBox(height: 16,),
                Text(

                  AppLocalization.of(context).translate('Congratulations, you have won the property. Kish staff will contact you')!,
                  textAlign: TextAlign.center,
                  style: Styles.getMidMainTextStyle(color: ColorManager.primary,fontSize: FontSize.s22),
                ),

              ],
            ),



          ),
        ):state==-2?
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Image(
                  height: 150,
                  width: 150,
                  image: AssetImage('icons/sorry.png'),
                ),
                const SizedBox(height: 16,),
                Text(

                  AppLocalization.of(context).translate('Sorry you didn\'t win the property, hope you get lucky again')!,
                  textAlign: TextAlign.center,
                  style:Styles.getMidMainTextStyle(color: ColorManager.primary,fontSize: FontSize.s22),
                ),

              ],
            ),



          ),
        ):null,
      ),

    );
  }
}
