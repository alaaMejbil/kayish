import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:kayish/blocs/done%20auction%20cubit/cubit.dart';
import 'package:kayish/blocs/done%20auction%20cubit/states.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/models/done_auction_model.dart';
import 'package:kayish/modules/deals_details_screen.dart';
import 'package:kayish/modules/finished_deals_details.dart';
import 'package:kayish/modules/sign_up_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';
import 'package:kayish/widgets/unit_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'layout_screen.dart';

class FinishedDealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => DoneAuctionCubit()..getDoneAuction(),
      child: BlocConsumer<DoneAuctionCubit, DoneStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DoneAuctionCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  AppLocalization.of(context).translate('Finished deals')!,
                  style: appBarTitle),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  HomeCubit.get(context).getHomeData(
                      cityId: 0,
                      regionId: 0,
                      districtId: 0,
                      realStateTypeId: 0);
                },
              ),
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
            ),
            body: Conditional.single(
                context: context,
                conditionBuilder: (context) => state is! DoneInitialState,
                widgetBuilder: (context) => cubit.doneAuctionModel != null
                    ? SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        controller: cubit.refreshController,
                        onRefresh: () async {
                          cubit.resetCurrentPage();
                          print(cubit.currentPage);
                          cubit.getDoneAuction(isRefresh: true).then((value) {
                            cubit.refreshController.refreshCompleted();
                            cubit.refreshController.resetNoData();
                          });
                        },
                        onLoading: () async {
                          cubit.getDoneAuction().then((value) {
                            print(cubit.currentPage);
                            if (cubit.currentPage <
                                cubit.doneAuctionModel!.data!.nextAuctions!
                                    .total!) {
                              cubit.refreshController.loadComplete();
                            } else {
                              print(cubit.currentPage);
                              cubit.refreshController.loadNoData();
                            }
                          });
                        },
                        child: cubit.allData.isNotEmpty
                            ? SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 4, right: 32, left: 32),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              AppLocalization.of(context)
                                                  .translate('Finished deals')!,
                                              style: onTabTextStyle),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            if (CasheHelper.getData(
                                                key: isVerified)) {
                                              navigateTo(
                                                  context: context,
                                                  nextScreen:
                                                      DealsDetailsScreen(
                                                          auctionId: cubit
                                                              .doneAuctionModel!
                                                              .data!
                                                              .nextAuctions!
                                                              .data[index]
                                                              .id!));
                                            } else {
                                              Alert(
                                                  context: context,
                                                  image: const Image(
                                                    height: 40,
                                                    width: 40,
                                                    image: AssetImage(
                                                        'icons/back_pop_up.png'),
                                                  ),
                                                  title: AppLocalization.of(
                                                          context)
                                                      .translate(
                                                          'You must register and verify the account before adding any bid'),
                                                  style: AlertStyle(
                                                    buttonsDirection:
                                                        ButtonsDirection.column,
                                                    alertBorder:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    titleStyle: Styles
                                                        .getMidMainTextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                FontSize.s16),
                                                  ),
                                                  buttons: [
                                                    DialogButton(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            color: ColorManager
                                                                .primary),
                                                        child: Text(
                                                          AppLocalization.of(
                                                                  context)
                                                              .translate(
                                                                  'Sign Up')!,
                                                          style: Styles
                                                              .getBoldMainTextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      FontSize
                                                                          .s18),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        navigateTo(
                                                            context: context,
                                                            nextScreen:
                                                                SignUpScreen());
                                                      },
                                                      radius:
                                                          BorderRadius.circular(
                                                              25),
                                                      height: 50,
                                                    ),
                                                    DialogButton(
                                                      child: Container(
                                                        child: Text(
                                                          AppLocalization.of(
                                                                  context)
                                                              .translate(
                                                                  'Later')!,
                                                          style: Styles
                                                              .getBoldMainTextStyle(
                                                                  color: ColorManager
                                                                      .primary,
                                                                  fontSize:
                                                                      FontSize
                                                                          .s18),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      radius:
                                                          BorderRadius.circular(
                                                              25),
                                                      height: 50,
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorManager
                                                              .primary),
                                                    ),
                                                  ]).show();
                                            }
                                          },
                                          child: UnitItem(
                                            screenType: 4,
                                            auctionId: cubit.allData[index].id,
                                            width: width * .75,
                                            image: cubit
                                                .allData[index].realestateImage,
                                            title: cubit
                                                .allData[index].realestateTitle,
                                            statusColor: Colors.grey.shade600,
                                            follow: false,
                                            borderColor: Colors.grey.shade600,
                                            auctionsNumber:
                                                cubit.allData[index].dealId,
                                            time: '2:25',
                                            distance: cubit
                                                .allData[index].realestateSpace,
                                            location:
                                                '${cubit.allData[index].realestateReigon} - ${cubit.allData[index].realestateCity}',
                                            price: cubit.allData[index].maximum
                                                .toString(),
                                            status: AppLocalization.of(context)
                                                .translate('Finished')!,
                                            unitType: cubit
                                                .allData[index].realestateType,
                                          ),
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 8,
                                        ),
                                        itemCount: cubit.allData.length,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  AppLocalization.of(context)
                                      .translate('No auctions')!,
                                  style: Styles.getBoldMainTextStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.s20),
                                ),
                              ),
                      )
                    : Center(
                        child: Text(AppLocalization.of(context)
                            .translate('No auction')!)),
                fallbackBuilder: (context) =>
                    Center(child: MyCircularPrograssIndicator())),
          );
        },
      ),
    );
  }
}
