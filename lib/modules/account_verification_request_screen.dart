

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/profile%20cubit/cubit.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/default_button.dart';

class AccountVerificationRequest extends StatelessWidget {
   bool success=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).translate('Account Verification Request')!,style: appBarTitle,),
        centerTitle: true,
        elevation: 0.0,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                 Image(
                  height: 125,
                  width: 125,
                  image:HomeCubit.get(context).homeModel!.data!.userStatus!=3? AssetImage('icons/clock.png'):AssetImage('icons/done.png'),
                ),
                const SizedBox(height: 16,),
                Text(

                  HomeCubit.get(context).homeModel!.data!.userStatus!=3?AppLocalization.of(context).translate('Your request is in progress')!:AppLocalization.of(context).translate('Your account has been successfully verified')!,
                  textAlign: TextAlign.center,
                  style:Styles.getMidMainTextStyle(color: ColorManager.primary,fontSize: FontSize.s22),
                ),

              ],
            ),



          ),
        ),
    //     Center(
    //   child: Container(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children:  [
    //       const Image(
    //         height: 125,
    //         width: 125,
    //         image: AssetImage('icons/done.png'),
    //       ),
    //       const SizedBox(height: 16,),
    //       Text(
    //
    //         AppLocalization.of(context).translate('Your account has been successfully verified')!,
    //         textAlign: TextAlign.center,
    //         style:Styles.getBoldMainTextStyle(color: Colors.black,fontSize: FontSize.s20)
    //       ),
    //
    //     ],
    //   ),
    //
    //
    //
    // ),
    // ),
    //   ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(32.0),
        child: DefaultButton(
          text: 'Back to the main page',
          onPressed: (){
            navigateTo(context: context, nextScreen: LayoutScreen());
            HomeCubit.get(context).getHomeData(realStateTypeId: 0,districtId: 0,regionId: 0,cityId: 0);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
