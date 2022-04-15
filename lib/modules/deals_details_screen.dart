import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:kayish/blocs/deals%20detais%20cubit/cubit.dart';
import 'package:kayish/blocs/deals%20detais%20cubit/states.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/profile%20cubit/cubit.dart';
import 'package:kayish/modules/home_screen.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/modules/map_screen.dart';
import 'package:kayish/modules/result_of_transaction.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/date_functions.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/widgets/build_description_item.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';
import 'package:kayish/widgets/deals_bids_item.dart';
import 'package:kayish/widgets/price_table_item.dart';
import 'package:readmore/readmore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'bids_screen.dart';

class DealsDetailsScreen extends StatelessWidget {
  int auctionId;

  DealsDetailsScreen({
    required this.auctionId,
  });

  List<String> photos = [
    'images/logo.png',
    'images/profile.png',
    'images/welcome.png'
  ];
  GlobalKey<FormState> bidFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DealsDetailsCubit()..getAuctionDetails(auctionId: auctionId),
      child: BlocConsumer<DealsDetailsCubit, DealsDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DealsDetailsCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                AppLocalization.of(context).translate('Auction details')!,
                style: appBarTitle,
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  navigateAndFinish(
                      context: context,
                      nextScreen: LayoutScreen(
                        pageNumber: 1,
                      ));
                  HomeCubit.get(context).getHomeData(
                      cityId: 0,
                      regionId: 0,
                      districtId: 0,
                      realStateTypeId: 0);
                },
              ),
              actions: [
                // IconButton(
                //   icon:const Image(
                //     height: 20,
                //     width: 20,
                //     color: Colors.black,
                //     image: AssetImage('icons/share.png'),
                //   ),
                //   onPressed: (){
                //
                //   },
                // ),
              ],
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) => state is! DealsDetailsInitialState,
              widgetBuilder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 5,
                                    spreadRadius: .5,
                                  ),
                                ]),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  height: 200,
                                  initialPage: 0,
                                  viewportFraction: 1.0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  onPageChanged: (index, reason) {
                                    cubit.changePageIndicator(index);
                                  },
                                  scrollDirection: Axis.horizontal),
                              items: cubit.dealsDetailsModel!.data!
                                  .auctionDetails!.realestateImages
                                  .map((e) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: e.image!,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        height: 200,
                                        placeholder: (context, url) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MyCircularPrograssIndicator(),
                                          ],
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                                height: 180,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color:
                                                        Colors.grey.shade400),
                                                child: const Icon(Icons.error)),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          AnimatedSmoothIndicator(
                            activeIndex: cubit.activePage,
                            count: cubit.dealsDetailsModel!.data!
                                .auctionDetails!.realestateImages.length,
                            effect: const JumpingDotEffect(
                              dotHeight: 10,
                              dotWidth: 10,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.dealsDetailsModel!.data!.auctionDetails!
                                    .realestateTitle!,
                                style: Styles.getMidMainTextStyle(
                                    color: Colors.black,
                                    fontSize: FontSize.s16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (cubit.dealsDetailsModel!.data!.auctionDetails!
                              .realestateProperties.isNotEmpty)
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalization.of(context)
                                          .translate('Specifications')!,
                                      style: Styles.getMidMainTextStyle(
                                          color: Colors.black,
                                          fontSize: FontSize.s16),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  height: 58,
                                  child: Scrollbar(
                                    controller: cubit.scrollController,
                                    isAlwaysShown: true,
                                    interactive: true,
                                    scrollbarOrientation:
                                        ScrollbarOrientation.bottom,
                                    child: ListView.separated(
                                      controller: cubit.scrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          BuildDescriptionItem(
                                        value: cubit
                                            .dealsDetailsModel!
                                            .data!
                                            .auctionDetails!
                                            .realestateProperties[index]
                                            .value,
                                        name: cubit
                                            .dealsDetailsModel!
                                            .data!
                                            .auctionDetails!
                                            .realestateProperties[index]
                                            .name,
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        width: 32,
                                      ),
                                      itemCount: cubit
                                          .dealsDetailsModel!
                                          .data!
                                          .auctionDetails!
                                          .realestateProperties
                                          .length,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 8,
                          ),
                          ReadMoreText(
                            cubit.dealsDetailsModel!.data!.auctionDetails!
                                .realestateDescription!,
                            style: bidsTextStyle,
                            trimLength: 100,
                            trimCollapsedText:
                                AppLocalization.of(context).translate('More')!,
                            trimExpandedText:
                                AppLocalization.of(context).translate('Less')!,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 6,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalization.of(context)
                                    .translate('Address')!,
                                style: Styles.getMidMainTextStyle(
                                    color: Colors.black,
                                    fontSize: FontSize.s16),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(start: 4),
                                child: Container(
                                  height: 35,
                                  child: TextButton(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: AppLocalization.of(context)
                                              .translate(
                                                  'Open the location on the map')!,
                                          style: textButtonStyle,
                                        ),
                                        TextSpan(
                                          text: '>',
                                          style: textButtonStyle,
                                        ),
                                      ]),
                                    ),
                                    onPressed: () {
                                      navigateTo(
                                          context: context,
                                          nextScreen: MapScreen(
                                            latitude: cubit.dealsDetailsModel!
                                                .data!.auctionDetails!.latitude,
                                            longtude: cubit
                                                .dealsDetailsModel!
                                                .data!
                                                .auctionDetails!
                                                .longitude,
                                            address: cubit.dealsDetailsModel!
                                                .data!.auctionDetails!.address,
                                          ));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                bottom: 16, end: 5),
                            child: Text(
                              '${cubit.dealsDetailsModel!.data!.auctionDetails!.realestateReigon!} -${cubit.dealsDetailsModel!.data!.auctionDetails!.realestateCity!}',
                              style: TextStyle(
                                fontFamily: 'GE',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 6,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 32),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalization.of(context)
                                .translate('property age')!,
                            style: Styles.getMidMainTextStyle(
                                color: Colors.black, fontSize: FontSize.s16),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            ':',
                            style: Styles.getMidMainTextStyle(
                                color: Colors.black, fontSize: FontSize.s16),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              ' ${cubit.dealsDetailsModel!.data!.auctionDetails!.age!}',
                              style: Styles.getBoldSecondryTextStyle(
                                  color: Colors.black, fontSize: FontSize.s16),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            ' ${AppLocalization.of(context).translate('years')}',
                            style: Styles.getBoldSecondryTextStyle(
                                color: Colors.black, fontSize: FontSize.s16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (cubit.dealsDetailsModel!.data!.auctionDetails!.status ==
                        1)
                      Container(
                        height: 6,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                      ),
                    if (cubit.dealsDetailsModel!.data!.auctionDetails!.status ==
                        1)
                      const SizedBox(
                        height: 16,
                      ),
                    if (cubit.dealsDetailsModel!.data!.auctionDetails!.status ==
                        1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          children: [
                            Text(
                              AppLocalization.of(context)
                                  .translate('Remaining time')!,
                              style: Styles.getMidMainTextStyle(
                                  color: Colors.black, fontSize: FontSize.s16),
                            ),
                            const SizedBox(width: 16),
                            Image(
                              height: 20,
                              width: 20,
                              color: Colors.grey.shade600,
                              image: const AssetImage('icons/watch.png'),
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: CountdownTimer(
                                endTime: currentAuctionCounter(
                                    endTime: cubit.dealsDetailsModel!.data!
                                        .auctionDetails!.endTime!),
                                onEnd: () {
                                  navigateTo(
                                      context: context,
                                      nextScreen: ResultOfTransactionScreen());
                                },
                                widgetBuilder:
                                    (context, CurrentRemainingTime? time) {
                                  if (time == null) {
                                    return Text(
                                      '00,00',
                                      style: timeTextStyle.copyWith(
                                          color: Colors.grey.shade600),
                                    );
                                  }
                                  return Text(
                                    '${time.min ?? '00'} : ${time.sec! >= 10 ? time.sec : '0${time.sec!}'}',
                                    textDirection: TextDirection.ltr,
                                    style: timeTextStyle.copyWith(
                                        color: Colors.grey.shade600),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (cubit.dealsDetailsModel!.data!.auctionDetails!.status ==
                        1)
                      const SizedBox(
                        height: 16,
                      ),
                    if (cubit.dealsDetailsModel!.data!.auctionDetails!.status ==
                        1)
                      Container(
                        height: 6,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                      ),
                    if (cubit.dealsDetailsModel!.data!.auctionDetails!.status ==
                        1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLocalization.of(context)
                                      .translate('Bids')!,
                                  style: Styles.getMidMainTextStyle(
                                      color: Colors.black,
                                      fontSize: FontSize.s16),
                                ),
                                Spacer(),
                                if (cubit.dealsDetailsModel!.data!
                                    .auctionDetails!.dealsTenders.isNotEmpty)
                                  InkWell(
                                    onTap: () {
                                      print('===>${auctionId}');
                                      navigateTo(
                                          context: context,
                                          nextScreen: BidsScreen(
                                            id: auctionId,
                                          ));
                                    },
                                    splashColor: ColorManager.primary,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalization.of(context)
                                              .translate('All')!,
                                          style: allTextStyle,
                                        ),
                                        const Center(
                                            child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: ColorManager.primary,
                                          size: 12,
                                        )),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            // Conditional.single(
                            //     context: context,
                            //     conditionBuilder: (context) =>
                            //         cubit.all.isNotEmpty,
                            //     widgetBuilder: (context) => Column(
                            //           children: [
                            //             DealsBidsItem(
                            //               name: cubit
                            //                   .dealsDetailsModel!
                            //                   .data!
                            //                   .auctionDetails!
                            //                   .dealsTenders[0]
                            //                   .name
                            //                   .toString(),
                            //               time:
                            //                   '${DateTime.parse(cubit.all.first.time!).hour} : ${DateTime.parse(cubit.all.first.time!).minute} : ${DateTime.parse(cubit.all.first.time!).second}',
                            //               date:
                            //                   '${DateTime.parse(cubit.all.first.time!).day} / ${DateTime.parse(cubit.all.first.time!).month} / ${DateTime.parse(cubit.all.first.time!).year}',
                            //               lastPrice: cubit
                            //                   .dealsDetailsModel!
                            //                   .data!
                            //                   .auctionDetails!
                            //                   .dealsTenders[0]
                            //                   .value
                            //                   .toString(),
                            //             ),
                            //             const SizedBox(
                            //               height: 4,
                            //             ),
                            //             Container(
                            //               height: 2,
                            //               width: double.infinity,
                            //               color: Colors.grey.shade200,
                            //             ),
                            //             // if (cubit.all.length >= 2)
                            //             //   const SizedBox(
                            //             //     height: 4,
                            //             //   ),
                            //             // if (cubit.all.length >= 2)
                            //             //   DealsBidsItem(
                            //             //     time:
                            //             //         '${DateTime.parse(cubit.all[1].time!).hour} : ${DateTime.parse(cubit.all[1].time!).minute} : ${DateTime.parse(cubit.all[1].time!).second}',
                            //             //     date:
                            //             //         '${DateTime.parse(cubit.all[1].time!).day} / ${DateTime.parse(cubit.all[1].time!).month} / ${DateTime.parse(cubit.all[1].time!).year}',
                            //             //     lastPrice: cubit.all[1].bidValue,
                            //             //   ),
                            //             // if (cubit.all.length >= 2)
                            //             //   const SizedBox(
                            //             //     height: 4,
                            //             //   ),
                            //             // if (cubit.all.length >= 2)
                            //             //   Container(
                            //             //     height: 2,
                            //             //     width: double.infinity,
                            //             //     color: Colors.grey.shade200,
                            //             //   ),
                            //             // if (cubit.all.length >= 3)
                            //             //   const SizedBox(
                            //             //     height: 4,
                            //             //   ),
                            //             // if (cubit.all.length >= 3)
                            //             //   DealsBidsItem(
                            //             //     time:
                            //             //         '${DateTime.parse(cubit.all[2].time!).hour} : ${DateTime.parse(cubit.all[2].time!).minute} : ${DateTime.parse(cubit.all[2].time!).second}',
                            //             //     date:
                            //             //         '${DateTime.parse(cubit.all[2].time!).day} / ${DateTime.parse(cubit.all[2].time!).month} / ${DateTime.parse(cubit.all[2].time!).year}',
                            //             //     lastPrice: cubit.all[2].bidValue,
                            //             //   ),
                            //           ],
                            //         ),
                            //     fallbackBuilder: (context) => Text(
                            //           AppLocalization.of(context)
                            //               .translate('There are no bids yet')!,
                            //           style: bidsTextStyle,
                            //         )),
                            ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cubit.allBids.length,
                              // itemCount: cubit.dealsDetailsModel!.data!
                              //             .auctionDetails!.dealsTenders.length >
                              //         3
                              //     ? 3
                              //     : cubit.dealsDetailsModel!.data!
                              //         .auctionDetails!.dealsTenders.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  DealsBidsItem(
                                    name: cubit.allBids[index].name.toString(),
                                    time: cubit.allBids[index].createdAt!
                                        .substring(11, 19),
                                    date: cubit.allBids[index].createdAt!
                                        .substring(0, 10),
                                    // time:
                                    //     '${DateTime.parse(cubit.all.first.time!).hour} : ${DateTime.parse(cubit.all.first.time!).minute} : ${DateTime.parse(cubit.all.first.time!).second}',
                                    // date:
                                    //     '${DateTime.parse(cubit.all.first.time!).day} / ${DateTime.parse(cubit.all.first.time!).month} / ${DateTime.parse(cubit.all.first.time!).year}',
                                    lastPrice: cubit
                                        .dealsDetailsModel!
                                        .data!
                                        .auctionDetails!
                                        .dealsTenders[index]
                                        .value
                                        .toString(),
                                  ),
                                  Container(
                                    height: 2,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  // if (cubit.all.length >= 2)
                                  //   const SizedBox(
                                  //     height: 4,
                                  //   ),
                                  // if (cubit.all.length >= 2)
                                  //   DealsBidsItem(
                                  //     time:
                                  //         '${DateTime.parse(cubit.all[1].time!).hour} : ${DateTime.parse(cubit.all[1].time!).minute} : ${DateTime.parse(cubit.all[1].time!).second}',
                                  //     date:
                                  //         '${DateTime.parse(cubit.all[1].time!).day} / ${DateTime.parse(cubit.all[1].time!).month} / ${DateTime.parse(cubit.all[1].time!).year}',
                                  //     lastPrice: cubit.all[1].bidValue,
                                  //   ),
                                  // if (cubit.all.length >= 2)
                                  //   const SizedBox(
                                  //     height: 4,
                                  //   ),
                                  // if (cubit.all.length >= 2)
                                  //   Container(
                                  //     height: 2,
                                  //     width: double.infinity,
                                  //     color: Colors.grey.shade200,
                                  //   ),
                                  // if (cubit.all.length >= 3)
                                  //   const SizedBox(
                                  //     height: 4,
                                  //   ),
                                  // if (cubit.all.length >= 3)
                                  //   DealsBidsItem(
                                  //     time:
                                  //         '${DateTime.parse(cubit.all[2].time!).hour} : ${DateTime.parse(cubit.all[2].time!).minute} : ${DateTime.parse(cubit.all[2].time!).second}',
                                  //     date:
                                  //         '${DateTime.parse(cubit.all[2].time!).day} / ${DateTime.parse(cubit.all[2].time!).month} / ${DateTime.parse(cubit.all[2].time!).year}',
                                  //     lastPrice: cubit.all[2].bidValue,
                                  //   ),
                                ],
                              ),
                            ),
                            if (cubit.dealsDetailsModel!.data!.auctionDetails!
                                .dealsTenders.isEmpty)
                              Text(
                                AppLocalization.of(context)
                                    .translate('There are no bids yet')!,
                                style: bidsTextStyle,
                              )
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 6,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              AppLocalization.of(context)
                                  .translate('Real estate transaction value')!,
                              style: bodyTextStyle.copyWith(
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '5%',
                                textAlign: TextAlign.center,
                                style: appBarTitle.copyWith(
                                    color: Colors.grey.shade600,
                                    fontFamily: 'Gill'),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              AppLocalization.of(context).translate(
                                  'This percentage is added to the property value')!,
                              textAlign: TextAlign.center,
                              style: bodyTextStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                  fontSize: 9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 6,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Text(
                    //   AppLocalization.of(context).translate('tenders')!,
                    //   style:
                    //       bodyTextStyle.copyWith(fontWeight: FontWeight.w400),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // if (cubit.dealsDetailsModel!.data!.auctionDetails!.status ==
                    //     1)
                    //   Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.grey.shade200,
                    //         boxShadow: [
                    //           BoxShadow(
                    //               color: Colors.grey.shade300,
                    //               spreadRadius: 1,
                    //               blurRadius: 2),
                    //         ]),
                    //     child: Container(
                    //       decoration: const BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.only(
                    //             topRight: Radius.circular(10),
                    //             topLeft: Radius.circular(10)),
                    //       ),
                    //       child: Column(
                    //         children: [
                    //           Row(
                    //             children: [
                    //               Expanded(
                    //                 child: Center(
                    //                   child: Text(
                    //                     AppLocalization.of(context)
                    //                         .translate('Name')!,
                    //                     style: bodyTextStyle.copyWith(
                    //                         fontWeight: FontWeight.w400),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Container(
                    //                 height: 40,
                    //                 width: 2,
                    //                 color: Colors.grey.shade400,
                    //               ),
                    //               Expanded(
                    //                 child: Center(
                    //                   child: Text(
                    //                     AppLocalization.of(context)
                    //                         .translate('Price')!,
                    //                     style: bodyTextStyle.copyWith(
                    //                         fontWeight: FontWeight.w400),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // Container(
                    //   height: 6,
                    //   width: double.infinity,
                    //   color: Colors.grey.shade200,
                    // ),
                    // if (cubit.dealsDetailsModel!.data!.auctionDetails!
                    //     .realestateProperties.isNotEmpty)
                    //   ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     itemCount: cubit.dealsDetailsModel!.data!
                    //         .auctionDetails!.dealsTenders.length,
                    //     itemBuilder: (context, index) => Row(
                    //       children: [
                    //         Expanded(
                    //           child: Center(
                    //             child: Text(
                    //               cubit.dealsDetailsModel!.data!.auctionDetails!
                    //                   .dealsTenders[index].name
                    //                   .toString(),
                    //               style: bodyTextStyle.copyWith(
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //           ),
                    //         ),
                    //         Container(
                    //           height: 40,
                    //           width: 2,
                    //           color: Colors.grey.shade400,
                    //         ),
                    //         Expanded(
                    //           child: Center(
                    //             child: Text(
                    //               AppLocalization.of(context)
                    //                   .translate('Price')!,
                    //               style: bodyTextStyle.copyWith(
                    //                   fontWeight: FontWeight.w400),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    if (cubit.dealsDetailsModel!.data!.auctionDetails!.status ==
                        3)
                      Padding(
                        padding: const EdgeInsets.only(right: 32, left: 32),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                AppLocalization.of(context)
                                    .translate('final price')!,
                                style: bodyTextStyle.copyWith(
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      cubit.dealsDetailsModel!.data!
                                          .auctionDetails!.maximumPrice!
                                          .toString(),
                                      style: bodyTextStyle.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Gill',
                                          color: ColorManager.primary),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    ' ${AppLocalization.of(context).translate('Sar')}',
                                    textAlign: TextAlign.center,
                                    style: bodyTextStyle.copyWith(
                                        color: Colors.black,
                                        fontFamily: 'Gill'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (cubit.dealsDetailsModel!.data!.auctionDetails!
                            .desireValue !=
                        0)
                      Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 26,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    AppLocalization.of(context)
                                        .translate('Desired price')!,
                                    style: bodyTextStyle.copyWith(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      '${cubit.dealsDetailsModel!.data!.auctionDetails!.desireValue} ${AppLocalization.of(context).translate('Sar')}',
                                      textAlign: TextAlign.center,
                                      style: appBarTitle.copyWith(
                                          color: ColorManager.primary,
                                          fontFamily: 'Gill'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 26,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (cubit.dealsDetailsModel!.data!.auctionDetails!.status ==
                        1)
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 2),
                            ]),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  PriceTableItem(
                                    title: 'Highest price',
                                    price: DealsDetailsCubit.get(context)
                                        .highestPrice
                                        .toString(),
                                  ),
                                  Container(
                                    height: 65,
                                    width: 2,
                                    color: Colors.grey.shade400,
                                  ),
                                  PriceTableItem(
                                    title: 'opening price',
                                    price: cubit.openingPrice!.toString(),
                                  ),
                                  Container(
                                    height: 65,
                                    width: 2,
                                    color: Colors.grey.shade400,
                                  ),
                                  PriceTableItem(
                                    title: 'Bid value',
                                    price: cubit.tenderValue!.toString(),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                width: double.infinity,
                                color: Colors.grey.shade400,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: const CircleAvatar(
                                              radius: 15,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              backgroundColor:
                                                  ColorManager.primary,
                                            ),
                                            onTap: () {
                                              cubit.increaseCounter();
                                              cubit.bidValueController.text =
                                                  '${cubit.bidCounter}';
                                            },
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .only(
                                                    start: 4,
                                                  ),
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            border: InputBorder
                                                                .none),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: bidValueTextStyle,
                                                    textAlign: TextAlign.center,
                                                    enabled: true,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          6),
                                                    ],
                                                    controller: cubit
                                                        .bidValueController,
                                                    onChanged: (value) {
                                                      if (value == '') {
                                                        cubit.bidCounter = 0;
                                                      } else {
                                                        cubit.bidCounter =
                                                            int.parse(value);
                                                      }
                                                    },
                                                  ),
                                                ),
                                                width: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          InkWell(
                                            child: const CircleAvatar(
                                              radius: 15,
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              ),
                                              backgroundColor:
                                                  ColorManager.primary,
                                            ),
                                            onTap: () {
                                              if (cubit.bidCounter! -
                                                      cubit.tenderValue! >=
                                                  cubit.tenderValue!) {
                                                cubit.decreaseCounter();
                                                cubit.bidValueController.text =
                                                    '${cubit.bidCounter}';
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      flex: 3,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(start: 32),
                                            child: InkWell(
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: ColorManager.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Image(
                                                        image: AssetImage(
                                                            'icons/hammar.png'),
                                                        height: 25,
                                                        width: 25,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        AppLocalization.of(
                                                                context)
                                                            .translate('Add')!,
                                                        style:
                                                            bottomNavIconTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        AppLocalization.of(
                                                                context)
                                                            .translate(
                                                                'Bidding')!,
                                                        style:
                                                            bottomNavIconTextStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                if (int.parse(cubit
                                                        .bidValueController
                                                        .text) <
                                                    cubit.tenderValue!) {
                                                  Alert(
                                                          style: AlertStyle(
                                                            buttonsDirection:
                                                                ButtonsDirection
                                                                    .column,
                                                            alertBorder:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            titleStyle: Styles
                                                                .getMidMainTextStyle(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600,
                                                                    fontSize:
                                                                        FontSize
                                                                            .s16),
                                                          ),
                                                          buttons: [
                                                            DialogButton(
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                    color: ColorManager
                                                                        .primary),
                                                                child: Text(
                                                                  AppLocalization.of(
                                                                          context)
                                                                      .translate(
                                                                          'Done')!,
                                                                  style: Styles.getBoldMainTextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          FontSize
                                                                              .s22),
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              radius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              height: 50,
                                                            ),
                                                          ],
                                                          context: context,
                                                          title:
                                                              '${AppLocalization.of(context).translate('Please add number more than')} ${cubit.dealsDetailsModel!.data!.auctionDetails!.tendersValue}')
                                                      .show();
                                                } else {
                                                  cubit
                                                      .increaseHighestPrice()
                                                      .then((value) {
                                                    // DealsDetailsCubit.get(
                                                    //         context)
                                                    //     .sendBid(
                                                    //         value: cubit
                                                    //             .highestPrice!
                                                    //             .toString(),
                                                    //         userId: ProfileCubit
                                                    //                 .get(
                                                    //                     context)
                                                    //             .profileModel!
                                                    //             .data!
                                                    //             .profile!
                                                    //             .id!,
                                                    //         auctionId:
                                                    //             auctionId);
                                                    cubit.sendBidToApi(
                                                        cubit.highestPrice!,
                                                        cubit
                                                            .dealsDetailsModel!
                                                            .data!
                                                            .auctionDetails!
                                                            .id!);
                                                  }).then((value) {
                                                    print(cubit.highestPrice!);
                                                    cubit.getAuctionDetails(
                                                        auctionId: auctionId);
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              fallbackBuilder: (context) =>
                  Center(child: MyCircularPrograssIndicator()),
            ),
          );
        },
      ),
    );
  }
}
