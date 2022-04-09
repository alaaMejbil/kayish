import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/cubit.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/states.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/tab_item.dart';

import 'Institution_account_screen.dart';
import 'account_verification_request_screen.dart';
import 'individual_account.dart';

class AccountVerification extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    var cubit=AccountVerificationCubit.get(context);
    return BlocConsumer<AccountVerificationCubit,AccountVerificationStates>(
      listener: (context,state){
        if(state is AccountVerificationSuccessfulState){
          navigateAndFinish(context: context, nextScreen: AccountVerificationRequest());
        }
      },
      builder:(context,state){
        return Scaffold(
          backgroundColor: ColorManager.lightGrey,
          appBar:  AppBar(
            title: Text(AppLocalization.of(context).translate('Account Verification')!,style: appBarTitle,),
            centerTitle: true,
            elevation: 0.0,
            leading:IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: (){
               navigateAndFinish(context: context, nextScreen: LayoutScreen(pageNumber: 1,));
                HomeCubit.get(context).getHomeData(cityId: 0,regionId: 0,districtId: 0,realStateTypeId: 0);
              },
            ),

            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),

          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TabItem(),
                  ),
                  const SizedBox(height: 16,),
                  if(cubit.currentIndex==0)
                    IndividualAccountScreen(),
                  if(cubit.currentIndex==1)
                    InstitutionAccountScreen(),
                  const SizedBox(height: 32,),

                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
