import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/blocs/InComingAuctionCubit/cubit.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/next%20auction%20cubit/cubit.dart';

import 'package:kayish/blocs/profile%20cubit/cubit.dart';
import 'package:kayish/models/home_model.dart';
import 'package:kayish/modules/account_verfication_screen.dart';
import 'package:kayish/modules/account_verification_request_screen.dart';
import 'package:kayish/modules/sign_up_screen.dart';
import 'package:kayish/shared/component/alert.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';
import 'package:kayish/widgets/unit_details_item.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'custom_image_network.dart';

class UnitItem extends StatefulWidget {
  double? width;
  String? image;
  String? auctionsNumber;
  String? unitType;
  String? distance;
  String? location;
  // Finished or Running now or timer
  String? status;
  String? title;
  String? time;
  String? price;
  // border color of container
  Color? borderColor;
  // status container color
  Color? statusColor;
  // follow button visible or not
  bool? follow;
  //live is visible or not
  bool? live;
  bool? enableStatus;
  bool? enableShare;
  bool? inComing;
  bool? isFinished;
  bool? fromTime;
  bool? followState;
  int? auctionId;
  bool? auctionFollow;
  GestureTapCallback? onFollowTab;
  int? screenType;

  UnitItem({
    required this.width,
    required this.auctionsNumber,
    required this.unitType,
    required this.title,
    required this.location,
    required this.distance,
    required this.time,
    required this.status,
    required this.price,
    required this.image,
    required this.auctionId,
    this.onFollowTab,
    //if screen type==1 home
    // screen type==2 current auction screen
    // screen type =3 next auction screen
    required this.screenType,
    this.borderColor = ColorManager.primary,
    this.statusColor = ColorManager.primary,
    this.follow = true,
    this.live = false,
    this.enableShare = true,
    this.enableStatus = true,
    this.inComing = false,
    this.isFinished = false,
    this.fromTime = false,
    this.followState,
  });

  @override
  State<UnitItem> createState() => _UnitItemState();
}

class _UnitItemState extends State<UnitItem> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(color: widget.borderColor!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.enableStatus!)
                Container(
                  height: 34,
                  width: widget.width! * .30,
                  decoration: BoxDecoration(
                    color: widget.statusColor!,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            widget.status!,
                            textScaleFactor: .85,
                            style: const TextStyle(
                                color: Colors.white, fontSize: FontSize.s14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      if (widget.live!)
                        Positioned.directional(
                          end: 15,
                          top: 5,
                          textDirection: Directionality.of(context),
                          child: const CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
              const Spacer(),
              if (widget.follow!)
                InkWell(
                  onTap: widget.onFollowTab,
                  child: Container(
                    height: 34,
                    width: widget.width! * .25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      border: Border.all(color: ColorManager.primary),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              (widget.screenType == 1 &&
                                          !HomeCubit.get(context).followedList[
                                              widget.auctionId]!) ||
                                      (widget.screenType == 2 &&
                                          !OnGoingAuctionCubit.get(context)
                                                  .currentFollowedList[
                                              widget.auctionId]!) ||
                                      (widget.screenType == 3 &&
                                          !InComingAuctionCubit.get(context)
                                                  .nextFollowedList[
                                              widget.auctionId]!)
                                  ? Icons.add
                                  : Icons.check,
                              color: ColorManager.primary,
                              size: 20,
                            ),
                            Text(
                              AppLocalization.of(context).translate('Follow')!,
                              style:
                                  const TextStyle(color: ColorManager.primary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                width: 8,
              ),
              // if (widget.enableShare!)
              //   Center(
              //     child: CircleAvatar(
              //         radius: widget.width! * .05,
              //         backgroundColor: Colors.grey.shade600,
              //         child: const Icon(
              //           Icons.share_outlined,
              //           color: Colors.white,
              //           size: 20,
              //         )),
              //   ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Styles.getMidMainTextStyle(
                color: Colors.black, fontSize: FontSize.s16),
          ),
          const SizedBox(
            height: 8,
          ),
          if (widget.fromTime == true)
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  color: Colors.grey.shade400,
                  size: 18,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  AppLocalization.of(context).translate('Ago')!,
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: FontSize.s16,
                      fontFamily: "GE",
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    widget.time!,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: FontSize.s16,
                        fontFamily: "Gill",
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 16,
          ),
          Stack(
            children: [
              // Container(
              //   height: 180,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     image:   DecorationImage(
              //       image:
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              Container(
                height: 180,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  // child: Image(
                  //   fit: BoxFit.fill,
                  //   image: NetworkImage(widget.image!),
                  //   height: 180,
                  //   width: double.infinity,
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: widget.image!,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 180,
                    placeholder: (context, url) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyCircularPrograssIndicator(),
                      ],
                    ),
                    errorWidget: (context, url, error) => Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade400),
                        child: const Icon(Icons.error)),
                  ),
                ),
              ),
              if (!widget.inComing!)
                Positioned(
                  bottom: 0,
                  left: widget.width! * .15,
                  right: widget.width! * .15,
                  child: Container(
                    height: 35,
                    decoration: const BoxDecoration(
                      color: ColorManager.darkYellow,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                    ),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: widget.isFinished == false
                                ? AppLocalization.of(context)
                                    .translate('Current Bid')!
                                : AppLocalization.of(context)
                                    .translate('Selling price')!,
                            style: const TextStyle(
                              fontFamily: 'GE',
                              fontWeight: FontWeight.w400,
                              fontSize: FontSize.s14,
                              color: Colors.white,
                            ),
                            children: [
                              const TextSpan(
                                text: '  :',
                                style: TextStyle(
                                  fontFamily: 'GE',
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.s14,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ' ${widget.price!}  ${AppLocalization.of(context).translate('Sar')}',
                                style: TextStyle(
                                  fontFamily:
                                      CasheHelper.getData(key: 'isArabic') ==
                                              true
                                          ? 'GE'
                                          : 'Gill',
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.s14,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          UnitDetailsItem(
            value: widget.auctionsNumber,
            title: 'Auctions Number',
            icon: 'icons/feather tag.png',
          ),
          SizedBox(
            height: 4,
          ),
          UnitDetailsItem(
            value: widget.unitType,
            title: 'Unit Type',
            icon: 'icons/homef.png',
          ),
          SizedBox(
            height: 4,
          ),
          UnitDetailsItem(
            value: widget.distance,
            title: 'Distance',
            icon: 'icons/distance.png',
          ),
          SizedBox(
            height: 4,
          ),
          UnitDetailsItem(
            value: widget.location,
            title: 'Location',
            icon: 'icons/feather map.png',
          ),
        ]),
      ),
    );
  }
}
