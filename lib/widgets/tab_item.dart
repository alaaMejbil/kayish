import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/cubit.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/states.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class TabItem extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var cubit= AccountVerificationCubit.get(context);
    return  BlocConsumer<AccountVerificationCubit,AccountVerificationStates>(
      listener: (context,state){},
      builder: (context,state){
        return Container(
          height: 52,
          width: double.infinity,
          decoration: BoxDecoration(
           color: ColorManager.primary.withOpacity(.4),
            borderRadius: BorderRadius.circular(10),

          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                    onTap: (){
                      cubit.changeCurrentIndex(0);
                    },
                  child: cubit.currentIndex==0?Container(
                    decoration: BoxDecoration(
                      color: cubit.currentIndex==0?
                      ColorManager.primary:ColorManager.primary.withOpacity(.6),
                      borderRadius: BorderRadius.circular(10),


                    ),
                    child: Center(
                      child: Text(
                      AppLocalization.of(context).translate('individual account')!,
                        textScaleFactor: .9,
                        textAlign: TextAlign.center,
                        style: cubit.currentIndex==0?onTabTextStyle:offTabTextStyle
                      ),
                    ),
                    height: 52,
                  ): Center(
                    child: Text(
                        AppLocalization.of(context).translate('individual account')!,
                         textScaleFactor: .9,
                         textAlign: TextAlign.center,
                        style: cubit.currentIndex==0?onTabTextStyle:offTabTextStyle
                    ),
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    cubit.changeCurrentIndex(1);
                  },
                  child:cubit.currentIndex==1? Container(
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                          AppLocalization.of(context).translate('Institution account(company)')!,
                        textScaleFactor: .9,
                        textAlign: TextAlign.center,
                        style: onTabTextStyle
                      ),
                    ),
                    height: 52,
                  ):Center(
                    child: Text(
                      AppLocalization.of(context).translate('Institution account(company)')!,
                    textScaleFactor: .9,

                      textAlign: TextAlign.center,
                      style: offTabTextStyle,
                    ),
                  ),
                ),
                flex: 4,
              ),
            ],

          ),

        );
      },

    );
  }
}
