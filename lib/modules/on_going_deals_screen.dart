import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/next%20auction%20cubit/cubit.dart';
import 'package:kayish/blocs/next%20auction%20cubit/states.dart';



import 'package:kayish/modules/deals_details_screen.dart';
import 'package:kayish/modules/result_of_transaction.dart';
import 'package:kayish/modules/sign_up_screen.dart';
import 'package:kayish/shared/component/alert.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';
import 'package:kayish/widgets/default_button.dart';
import 'package:kayish/widgets/unit_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'account_verfication_screen.dart';
import 'account_verification_request_screen.dart';
import 'layout_screen.dart';

class OnGoingDealsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context)=>OnGoingAuctionCubit()..getOnGoingAuction(),
      child: BlocConsumer<OnGoingAuctionCubit,OnGoingStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=OnGoingAuctionCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.lightGrey,
            appBar:  AppBar(
              title: Text(AppLocalization.of(context).translate('Ongoing Deals')!,style: appBarTitle),
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
              conditionBuilder:(context)=> state is !OnGoingInitialState,
              widgetBuilder: (context)=>cubit.onGoingAuctionModel!=null?SmartRefresher(
                controller: cubit.refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: ()async{
                  cubit.resetCurrentPage();
                  print(cubit.currentPage);
                  cubit.getOnGoingAuction(isRefresh: true).then((value) {
                    cubit.refreshController.refreshCompleted();
                    cubit.refreshController.resetNoData();

                  });
                },
                onLoading:()async{
                  cubit.getOnGoingAuction().then((value) {
                    print(cubit.currentPage);
                    if(cubit.currentPage<cubit.onGoingAuctionModel!.data!.nextAuctions!.total!) {
                      cubit.refreshController.loadComplete();
                    }
                    else{
                      print(cubit.currentPage);
                      cubit.refreshController.loadNoData();
                    }

                  });
                },
                child:cubit.allData.isNotEmpty? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16,bottom: 4,right: 32,left: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalization.of(context).translate('Ongoing Deals')!,style: onTabTextStyle),
                          ],
                        ),
                        const SizedBox(height: 16,),
                        ListView.separated(
                          shrinkWrap: true,
                          physics:const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index)=>InkWell(
                            onTap: (){

                              if(CasheHelper.getData(key: isVerified)) {
                                if(cubit.allData[index].endTime!*1000-DateTime.now().millisecondsSinceEpoch>0){
                                  navigateTo(context: context, nextScreen: DealsDetailsScreen(auctionId: cubit.allData[index].id!));
                                }
                              else{
                                navigateTo(context: context, nextScreen: ResultOfTransactionScreen());
                              }
                              }
                              else {
                                if(CasheHelper.getData(key: isNotRegister)==true){
                                  Alert(
                                      context: context,
                                      image:const Image(
                                        height: 40,
                                        width: 40,
                                        image: AssetImage('icons/back_pop_up.png'),
                                      ),
                                      title: AppLocalization.of(context).translate('You must register and verify the account before adding any bid'),

                                      style:AlertStyle(

                                        buttonsDirection: ButtonsDirection.column,
                                        alertBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        titleStyle:Styles.getMidMainTextStyle(color: Colors.grey.shade600,fontSize: FontSize.s16),

                                      ),
                                      buttons: [

                                        DialogButton(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: ColorManager.primary

                                            ),
                                            child: Text(
                                              AppLocalization.of(context).translate('Sign Up')!,
                                              style:  Styles.getBoldMainTextStyle(color: Colors.white,fontSize: FontSize.s18),
                                            ),

                                          ),
                                          onPressed: (){
                                            navigateTo(context: context, nextScreen: SignUpScreen());
                                          },
                                          radius: BorderRadius.circular(25),
                                          height: 50,
                                        ),
                                        DialogButton(
                                          child: Container(

                                            child: Text(
                                              AppLocalization.of(context).translate('Later')!,
                                              style: Styles.getBoldMainTextStyle(color: ColorManager.primary,fontSize: FontSize.s18),
                                            ),

                                          ),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          radius: BorderRadius.circular(25),
                                          height: 50,
                                          color: Colors.white,
                                          border: Border.all(color: ColorManager.primary),
                                        ),


                                      ]
                                  ).show();
                                }
                                else if(CasheHelper.getData(key: isLogin)==true){
                                  Alert(
                                      context: context,
                                      image:const Image(
                                        height: 40,
                                        width: 40,
                                        image: AssetImage('icons/back_pop_up.png'),
                                      ),
                                      title: AppLocalization.of(context).translate('You must verify the account before adding any bid'),

                                      style:AlertStyle(
                                        buttonsDirection: ButtonsDirection.column,
                                        alertBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        titleStyle:Styles.getMidMainTextStyle(color: Colors.grey.shade600,fontSize: FontSize.s16),

                                      ),
                                      buttons: [
                                        DialogButton(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: ColorManager.primary

                                            ),
                                            child: Text(
                                              AppLocalization.of(context).translate('Account Verification')!,
                                              style:  Styles.getBoldMainTextStyle(color: Colors.white,fontSize: FontSize.s18),
                                            ),

                                          ),
                                          onPressed: (){
                                            navigateTo(context: context, nextScreen:AccountVerification());
                                          },
                                          radius: BorderRadius.circular(25),
                                          height: 50,
                                        ),
                                        DialogButton(
                                          child: Container(

                                            child: Text(
                                              AppLocalization.of(context).translate('Later')!,
                                              style:  Styles.getBoldMainTextStyle(color:ColorManager.primary,fontSize: FontSize.s18),
                                            ),

                                          ),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          radius: BorderRadius.circular(25),
                                          height: 50,
                                          color: Colors.white,
                                          border: Border.all(color: ColorManager.primary),
                                        ),

                                      ]
                                  ).show();
                                }
                                else if(CasheHelper.getData(key: isNotVerified)==true){
                                  Alert(
                                      context: context,
                                      image:const Image(
                                        height: 40,
                                        width: 40,
                                        image: AssetImage('icons/back_pop_up.png'),
                                      ),
                                      title: AppLocalization.of(context).translate('You must verify the account before adding any bid'),

                                      style:AlertStyle(
                                        buttonsDirection: ButtonsDirection.column,
                                        alertBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        titleStyle:Styles.getMidMainTextStyle(color: Colors.grey.shade600,fontSize: FontSize.s16),

                                      ),
                                      buttons: [
                                        DialogButton(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: ColorManager.primary

                                            ),
                                            child: Text(
                                              AppLocalization.of(context).translate('Account Verification')!,
                                              style:  Styles.getBoldMainTextStyle(color: Colors.white,fontSize: FontSize.s18),
                                            ),

                                          ),
                                          onPressed: (){
                                            navigateTo(context: context, nextScreen:AccountVerification());
                                          },
                                          radius: BorderRadius.circular(25),
                                          height: 50,
                                        ),
                                        DialogButton(
                                          child: Container(

                                            child: Text(
                                              AppLocalization.of(context).translate('Later')!,
                                              style:  Styles.getBoldMainTextStyle(color:ColorManager.primary,fontSize: FontSize.s18),
                                            ),

                                          ),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          radius: BorderRadius.circular(25),
                                          height: 50,
                                          color: Colors.white,
                                          border: Border.all(color: ColorManager.primary),
                                        ),

                                      ]
                                  ).show();
                                }
                              }
                            },
                            child: UnitItem(
                              screenType: 2,
                              onFollowTab: (){
                                if(!CasheHelper.getData(key: isVerified)){
                                  MyAlert.myAlert(
                                      context: context,
                                      title:  'Please register and verify your account before proceeding with any auction',
                                      assetImage: 'icons/back_pop_up.png',
                                      buttons: [
                                        DialogButton(
                                          child: Container(

                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                color: ColorManager.primary

                                            ),
                                            child: Text(
                                              AppLocalization.of(context)
                                                  .translate(CasheHelper.getData(key: isLogin)||CasheHelper.getData(key: isNotVerified)?'Account Verification':'Sign Up')!,
                                              style: Styles
                                                  .getBoldMainTextStyle(
                                                  color: Colors.white,
                                                  fontSize: FontSize.s18),
                                            ),

                                          ),
                                          onPressed: () {
                                            if(CasheHelper.getData(key: isLogin)||CasheHelper.getData(key: isNotVerified)){
                                              if(CasheHelper.getData(key: isLogin)){
                                                navigateTo(context: context,
                                                    nextScreen: AccountVerification());
                                              }
                                              else if(CasheHelper.getData(key: isNotVerified)){
                                                navigateAndFinish(context: context,
                                                    nextScreen: AccountVerificationRequest());
                                              }
                                              else {
                                                print ('verifid');
                                              }

                                            }
                                            else if(CasheHelper.getData(key: isNotRegister)){
                                              navigateTo(context: context,
                                                  nextScreen: SignUpScreen());
                                            }
                                            else{
                                              print( 'verified');
                                            }

                                          },
                                          radius: BorderRadius.circular(25),
                                          height: 50,
                                        ),
                                        DialogButton(
                                          child: Container(

                                            child: Text(
                                              AppLocalization.of(context)
                                                  .translate('Later')!,
                                              style: Styles
                                                  .getBoldMainTextStyle(
                                                  color: ColorManager
                                                      .primary,
                                                  fontSize: FontSize.s18),
                                            ),

                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          radius: BorderRadius.circular(25),
                                          height: 50,
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorManager.primary),
                                        ),
                                      ]
                                  );
                                }
                                else{
                                 cubit.currentFollowedList[cubit.allData[index].id!]=!cubit.currentFollowedList[cubit.allData[index].id!]!;
                                 cubit.addFollow(cubit.allData[index].id!);
                                }
                              },
                              auctionId: cubit.allData[index].id,
                              image: cubit.allData[index].realestateImage,
                              width: width*.75,
                              followState: cubit.allData[index].followed,
                              title: cubit.allData[index].realestateTitle,
                              auctionsNumber:  cubit.allData[index].dealId,
                              inComing: true,
                              time: '2:25',
                              distance:  cubit.allData[index].realestateSpace,
                              location: '${ cubit.allData[index].realestateReigon} -${ cubit.allData[index].realestateCity}',
                              price: '2532422',
                              status: AppLocalization.of(context).translate('Running now'),
                              unitType:  cubit.allData[index].realestateType,



                            ),
                          ),
                          separatorBuilder:(context,index)=> const SizedBox(height: 8,),
                          itemCount:  cubit.allData.length,

                        ),
                      ],
                    ),
                  ),
                ):
                Center(
                  child: Text(
                    AppLocalization.of(context).translate('No auctions')!,
                    style: Styles.getBoldMainTextStyle(color: Colors.black,fontSize: FontSize.s20),
                  ),
                )
              ): Center(
                child: Text(
                  AppLocalization.of(context).translate('No content')!,
                  style: Styles.getBoldMainTextStyle(color: Colors.black,fontSize: FontSize.s20),
                ),
              ),
              fallbackBuilder: (context)=>Center(child: MyCircularPrograssIndicator()),
            ),
          );
        },

      ),
    );
  }
}
