

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/how%20it%20work%20cubit/cubit.dart';
import 'package:kayish/blocs/how%20it%20work%20cubit/states.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';

import 'package:webview_flutter/webview_flutter.dart';

class AboutAppScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HowItWorkCubit()..getHowItWorkInfo()..myWebViewInit(),
      child: BlocConsumer<HowItWorkCubit,HowItWorkStates>(
        listener: (context,states){},
        builder: (context,state){
          var cubit=HowItWorkCubit.get(context);
          print('==============>${cubit.howItWorkModel}');
          return  Scaffold(
            appBar:  AppBar(
              title: Text(AppLocalization.of(context).translate('how do we work')!,style: appBarTitle),
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
            body: Conditional.single(
              context: context,
              conditionBuilder: (context)=>state is! HowItWorkInitialState,
               widgetBuilder:(context)=> cubit.howItWorkModel!=null?SingleChildScrollView(
                 child: Column(

                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.start,

                   children: [
                     Padding(
                       padding: const EdgeInsetsDirectional.only(top: 16,start: 44),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             AppLocalization.of(context).translate('How does Kish app work')!,
                             style: Styles.getBoldMainTextStyle(color: Colors.grey.shade800,fontSize: FontSize.s16),
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(height: 16,),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 32),
                       child: Container(
                         height: 220,
                         width: double.infinity,
                         decoration: BoxDecoration(
                           color: Colors.grey,
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(10),
                           child:   WebView(
                             javascriptMode: JavascriptMode.unrestricted,
                             initialUrl:cubit.howItWorkModel!.data!.video!,
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(height: 16,),

                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16),
                       child: Text(
                     cubit.howItWorkModel!.data!.about!,
                           textAlign: TextAlign.center,
                           softWrap: true,
                           textWidthBasis: TextWidthBasis.longestLine,


                           style: TextStyle(
                               fontSize: 14,
                               fontFamily: 'GE',
                               fontWeight: FontWeight.w400,
                               color: Colors.grey.shade800,
                               height: 3
                           )

                       ),
                     ),
                   ],
                 ),
               ):
                   Center(
                     child: Text(
                       AppLocalization.of(context).translate('No content')!,
                       style: Styles.getBoldMainTextStyle(color: Colors.black,fontSize: FontSize.s20),
                     ),
                   ),
                   // const Center(child: Text('No Content')),
              fallbackBuilder: (context)=>Center(child: MyCircularPrograssIndicator()),

            ),
          );
        },

      ),
    );
  }
}