import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:kayish/blocs/notification%20cubit/cubit.dart';
import 'package:kayish/blocs/notification%20cubit/states.dart';
import 'package:kayish/modules/deals_details_screen.dart';
import 'package:kayish/shared/component/date_functions.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';
import 'package:kayish/widgets/defualt_text.dart';

import '../widgets/notification_Item.dart';

class NotificationScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
      create: (context)=>NotificationsCubit()..getNotifications(),
      child: BlocConsumer<NotificationsCubit,NotificationsStates>(
        listener: (context,states){},
        builder: (context,state){
          var cubit= NotificationsCubit.get(context);
          return Scaffold(

            body: Conditional.single(
              context: context,
              conditionBuilder: (context)=>state is ! NotificationsInitialState,
              widgetBuilder: (context)=>cubit.notificationModel!=null? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top:16),
                  child:cubit.notificationModel!.data!.done.isNotEmpty||cubit.notificationModel!.data!.postponed.isNotEmpty? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        color: Colors.grey[200],
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start:16.0),
                          child: Row(

                            children: [
                              Text(
                                AppLocalization.of(context).translate('Recent')!,
                                style: bodyTextStyle,



                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index)=> InkWell(
                              onTap: (){
                              navigateTo(context: context, nextScreen: DealsDetailsScreen(auctionId: cubit.notificationModel!.data!.postponed[index].auctionId!));
                              },
                              child: NotificationItem(
                                title: cubit.notificationModel!.data!.postponed[index].title!,
                                image: 'images/notification_image.png',
                                date:notificationDate(cubit.notificationModel!.data!.postponed[index].date!),
                                time: notificationTime(cubit.notificationModel!.data!.postponed[index].date!),
                              ),
                            ),
                            separatorBuilder: (context,index)=> Divider(
                              height: 2,
                              color: Colors.grey.shade400,
                              thickness: 1,
                            ),
                            itemCount: cubit.notificationModel!.data!.postponed.length,
                          ),
                          Divider(
                            height: 2,
                            color: Colors.grey.shade400,
                            thickness: 1,
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        color: Colors.grey[200],
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start:16.0),
                          child: Row(

                            children: [
                              Text(
                                AppLocalization.of(context).translate('Oldest')!,
                                style: bodyTextStyle,



                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index)=> InkWell(
                              onTap: (){
                                navigateTo(context: context, nextScreen: DealsDetailsScreen(auctionId: cubit.notificationModel!.data!.done[index].auctionId!));
                              },
                              child: NotificationItem(
                                title:cubit.notificationModel!.data!.done[index].title!,
                                image: 'images/notification_image.png',
                                date: notificationDate(cubit.notificationModel!.data!.done[index].date!),
                                time: notificationTime(cubit.notificationModel!.data!.done[index].date!),
                              ),
                            ),
                            separatorBuilder: (context,index)=>Divider(
                              height: 2,
                              color: Colors.grey.shade400,
                              thickness: 1,
                            ),
                            itemCount: cubit.notificationModel!.data!.done.length,
                          ),

                          Divider(
                            height: 2,
                            color: Colors.grey.shade400,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ],
                  )
                      : Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppLocalization.of(context).translate('No notifications found')!),
                        ],
                      )),
                ),
              ):
              Center(child: Text(AppLocalization.of(context).translate('No notifications found')!)),
              fallbackBuilder:(context)=>Center(child: MyCircularPrograssIndicator()),
            ),
          );
        },

      ),
    );
  }
}