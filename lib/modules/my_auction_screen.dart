import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/my%20auction%20cubit/cubit.dart';
import 'package:kayish/blocs/my%20auction%20cubit/states.dart';
import 'package:kayish/modules/deals_details_screen.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/modules/sign_up_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';
import 'package:kayish/widgets/default_button.dart';
import 'package:kayish/widgets/unit_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyAuctionScreen extends StatelessWidget {
  bool user=false;

  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context)=>MyAuctionCubit()..getMyAuction(),
      child: BlocConsumer<MyAuctionCubit,MyAuctionStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=MyAuctionCubit.get(context);
          return Scaffold(
            appBar:  AppBar(
              title: Text(AppLocalization.of(context).translate('My auctions')!,style: appBarTitle),
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
            body:Conditional.single(
              context: context,
              conditionBuilder: (context)=>state is !MyAuctionInitialState,
              widgetBuilder: (context)=>cubit.myAuctionModel!=null?cubit.myAuctionModel!.data!.myAuctions.isNotEmpty?Padding(
                padding: const EdgeInsets.only(top: 16,bottom: 4,left: 32,right: 32),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalization.of(context).translate('My previous auctions')!,style: onTabTextStyle),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      ListView.separated(
                        shrinkWrap: true,
                        physics:const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index)=>InkWell(
                          onTap: (){

                          },
                          child: UnitItem(
                            screenType: 5,
                            auctionId: cubit.myAuctionModel!.data!.myAuctions[index].id,
                            image: '',
                            width: width*.75,
                            enableStatus: false,
                            enableShare: false,
                            follow: false,

                            title: 'فيلا في الساحل الشمالي',

                            auctionsNumber: '10',
                            time: '2:25',
                            distance: '250',
                            location: 'vdfgfbnngngf',
                            price: '2532422',
                            status: AppLocalization.of(context).translate('Running now'),
                            unitType: 'villa',



                          ),
                        ),
                        separatorBuilder:(context,index)=> const SizedBox(height: 8,),
                        itemCount: cubit.myAuctionModel!.data!.myAuctions.length,

                      ),
                    ],
                  ),
                ),
              ):
              Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('icons/pig_hammer.png'),
                      ),
                      const SizedBox(height: 16,),
                      Text(

                        AppLocalization.of(context).translate('There are no auctions')!,
                        textAlign: TextAlign.center,
                        style: Styles.getMidMainTextStyle(color: ColorManager.primary,fontSize: FontSize.s22),
                      ),

                    ],
                  ),



                ),
              )
              :Center(
                child: Center(
                  child: Text(
                    AppLocalization.of(context).translate('No content')!,
                    style: Styles.getBoldMainTextStyle(color: Colors.black,fontSize: FontSize.s20),
                  ),
                ),
              ),
              fallbackBuilder: (context)=>Center(child: MyCircularPrograssIndicator()),

            )
          );
        },

      ),
    );
  }
}
