import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/deals_bids_item.dart';
import 'package:kayish/widgets/price_table_item.dart';
import 'package:readmore/readmore.dart';

import 'bids_screen.dart';


class FinishedDealsDetails extends StatelessWidget {
  List<String> photos=['images/logo.png','images/profile.png','images/welcome_image.png'];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalization.of(context).translate('Finished deals')!,
            style: appBarTitle),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions:  [
          IconButton(
            icon:const Image(
              height: 20,
              width: 20,
              color: Colors.black,
              image: AssetImage('icons/share.png'),
            ),
            onPressed: (){

            },
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
      ),
      body: SingleChildScrollView(

        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(15),
                        boxShadow:  [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 1,
                            spreadRadius: .5,
                          ),
                        ]

                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: 200,
                          initialPage: 0,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal),
                      items:photos.map((e) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                image: AssetImage(e),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context).translate('Specifications')!,
                        style: Styles.getMidMainTextStyle(color: Colors.black,fontSize: FontSize.s16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 3
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text(
                                '5',
                                textAlign: TextAlign.center,
                                style: detailsTextStyle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            AppLocalization.of(context).translate('Rooms')!,
                            style: bidsTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 3
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text(
                                '5',
                                textAlign: TextAlign.center,
                                style: detailsTextStyle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            AppLocalization.of(context).translate('Kitchen')!,
                            style: bidsTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 3
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text(
                                '5',
                                textAlign: TextAlign.center,
                                style: detailsTextStyle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            AppLocalization.of(context).translate('Bathroom')!,
                            style: bidsTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 3
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text(
                                '5',
                                textAlign: TextAlign.center,
                                style: detailsTextStyle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            AppLocalization.of(context).translate('Salon')!,
                            style: bidsTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 3
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text(
                                '5',
                                textAlign: TextAlign.center,
                                style: detailsTextStyle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            AppLocalization.of(context).translate('Garden')!,
                            style: bidsTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 3
                                  ),
                                ]
                            ),
                            child: Center(
                              child: Text(
                                '5',
                                textAlign: TextAlign.center,
                                style: detailsTextStyle,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text(
                            AppLocalization.of(context).translate('Parking')!,
                            style: bidsTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8,),
                  ReadMoreText(
                    'فيلا في موقع مميز جدا للبيع في جدة مساحتها 1500 متر مربع و عمر هذه الفيلا سنتين تم تشطبيها علي طراز رفيع المستوي dsfds',
                    style: bidsTextStyle,
                    trimLength: 100,
                    trimCollapsedText:AppLocalization.of(context).translate('More')! ,
                    trimExpandedText: AppLocalization.of(context).translate('Less')!,

                  ),
                ],
              ),
            ),

            Container(
              height :6,
              width: double.infinity,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      AppLocalization.of(context).translate('Address')!,
                      style: Styles.getMidMainTextStyle(color: Colors.black,fontSize: FontSize.s16),
                    ),
                  ),
                  SizedBox(width: 16,),

                  Expanded(
                    flex: 2,
                    child: Text(
                      'جده',

                      style: TextStyle(
                        fontFamily: 'GE',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 4),
                      child: TextButton(
                        child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text:  AppLocalization.of(context).translate('Open the location on the map')!,

                                  style:textButtonStyle,
                                ),
                                TextSpan(
                                  text: '>',
                                  style:textButtonStyle,

                                ),
                              ]
                          ),
                        ),
                        onPressed: (){

                        },
                      ),
                    ),
                  ),



                ],
              ),
            ),
            Container(
              height :6,
              width: double.infinity,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(

                children: [
                  Text(
                    AppLocalization.of(context).translate('Remaining time')!,
                    style: Styles.getMidMainTextStyle(color: Colors.black,fontSize: FontSize.s16),
                  ),

                  const  SizedBox(width: 16),
                  Image(
                    height: 20,
                    width: 20,
                    color: Colors.grey.shade600,
                    image: const AssetImage('icons/watch.png'),
                  ),
                  const  SizedBox(width: 16),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '42:27',
                      style: timeTextStyle.copyWith(color: Colors.grey.shade600),
                    ),
                  ),






                ],
              ),
            ),
            const SizedBox(height: 16,),
            Container(
              height :6,
              width: double.infinity,
              color: Colors.grey.shade200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        AppLocalization.of(context).translate('Bids')!,
                        style: Styles.getMidMainTextStyle(color: Colors.black,fontSize: FontSize.s16),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: InkWell(
                          onTap: (){
                            navigateTo(context: context, nextScreen: BidsScreen(id: 1,));
                          },
                          splashColor: ColorManager.primary,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalization.of(context).translate('All')!,
                                style: allTextStyle,


                              ),
                              const Center(child:  Icon(Icons.arrow_forward_ios,color: ColorManager.primary,size: 12,)),


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  DealsBidsItem(
                    time: '8:00',
                    date: '28/10/2020',
                    lastPrice: '14000',
                  ),
                  const SizedBox(height: 4,),
                  Container(
                    height :2,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 4,),
                  DealsBidsItem(
                    time: '8:00',
                    date: '28/10/2020',
                    lastPrice: '14000',
                  ),
                  const SizedBox(height: 4,),
                  Container(
                    height :2,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 4,),
                  DealsBidsItem(
                    time: '8:00',
                    date: '28/10/2020',
                    lastPrice: '14000',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16,),
            Container(
              height :6,
              width: double.infinity,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      AppLocalization.of(context).translate('Real estate transaction value')!,
                      style: bodyTextStyle.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '5%',

                        textAlign: TextAlign.center,
                        style: appBarTitle.copyWith(color: Colors.grey.shade600,fontFamily: 'Gill'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      AppLocalization.of(context).translate('This percentage is added to the property value')!,
                      textAlign: TextAlign.center,
                      style: bodyTextStyle.copyWith(fontWeight: FontWeight.w400,color: Colors.grey.shade600,fontSize: 9),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 16,),
            Container(
              height :6,
              width: double.infinity,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.only(right: 32,left: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      AppLocalization.of(context).translate('final price')!,
                     style: bodyTextStyle.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '25000000',
                      style: bodyTextStyle.copyWith(fontWeight: FontWeight.w400,fontFamily: 'Gill'),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 32,),










          ],

        ),
      ),

    );
  }
}
