import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/deals%20detais%20cubit/cubit.dart';
import 'package:kayish/blocs/deals%20detais%20cubit/states.dart';


import 'package:kayish/modules/app.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/deals_bids_item.dart';
import 'package:kayish/widgets/price_table_item.dart';
import 'package:readmore/readmore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class RestartAuctionScreen extends StatelessWidget {
  List<String> photos=['images/logo.png','images/profile.png','images/welcome.png'];
  GlobalKey<FormState> bidFormKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var cubit= DealsDetailsCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalization.of(context).translate('Ongoing Deals')!,
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
                            color: Colors.grey.shade200,
                            blurRadius: 5,
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
                    height: 25,
                    width: 25,
                    color: Colors.grey.shade600,
                    image: const AssetImage('icons/watch.png'),
                  ),
                  const  SizedBox(width: 16),
                  Text(
                    '42:27',
                    style: timeTextStyle.copyWith(color: Colors.grey.shade600),
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
                      TextButton(
                        child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text:  AppLocalization.of(context).translate('All')!,

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
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(


                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      AppLocalization.of(context).translate('Desired price')!,
                      style: bodyTextStyle.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '1000000 ${AppLocalization.of(context).translate('Sar')}',

                        textAlign: TextAlign.center,
                        style: appBarTitle.copyWith(color:ColorManager.primary,fontFamily: 'Gill'),
                      ),
                    ),
                  ),


                ],
              ),
            ),
            const SizedBox(height: 16,),
            Container(
              height :26,
              width: double.infinity,
              color: Colors.grey.shade200,
            ),

            Container(
              decoration:  BoxDecoration(
                  color: Colors.grey.shade200,

                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 2
                    ),
                  ]
              ),
              child: BlocConsumer<DealsDetailsCubit,DealsDetailsStates>(
                listener: (context,state){},
                builder: (context,state){
                  return Container(
                    decoration:   const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),


                    ),
                    child: Column(
                      children: [
                        Row(

                          children: [
                            PriceTableItem(
                              title: 'Highest price',
                              price: '${cubit.highestPrice}',
                            ),
                            Container(
                              height: 65,
                              width: 2,
                              color: Colors.grey.shade400,
                            ),
                            PriceTableItem(
                              title: 'opening price',
                              price: '125000',
                            ),
                            Container(
                              height: 65,
                              width: 2,
                              color: Colors.grey.shade400,
                            ),
                            PriceTableItem(
                              title: 'Bid value',
                              price: '10000',
                            ),

                          ],
                        ),

                        Container(
                          height :2,
                          width: double.infinity,
                          color: Colors.grey.shade400,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    InkWell(
                                      child: const CircleAvatar(
                                        radius: 15,
                                        child: Icon(Icons.add,color: Colors.white,),
                                        backgroundColor: ColorManager.primary,
                                      ),
                                      onTap: (){
                                        cubit.increaseCounter();
                                        cubit.bidValueController.text='${cubit.bidCounter}';
                                      },


                                    ),

                                    Expanded(

                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional.only(start: 4,),
                                            child: TextFormField(

                                              decoration: const InputDecoration(

                                                  border: InputBorder.none
                                              ),
                                              keyboardType: TextInputType.number,
                                              style: bidValueTextStyle,
                                              textAlign: TextAlign.center,
                                              enabled: true,
                                              inputFormatters: [ LengthLimitingTextInputFormatter(6),],
                                              controller: cubit.bidValueController,
                                              onChanged: (value){
                                                if(value=='') {
                                                  cubit.bidCounter=0;
                                                } else {

                                                  cubit.bidCounter=int.parse(value);
                                                }



                                              },




                                            ),
                                          ),
                                          width: 30,
                                        ),
                                      ),
                                    ),

                                    InkWell(
                                      child: const CircleAvatar(
                                        radius: 15,
                                        child: Icon(Icons.remove,color: Colors.white,),
                                        backgroundColor: ColorManager.primary,
                                      ),
                                      onTap: (){
                                        if(cubit.bidCounter!-10000>=10000) {
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
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(start: 32),
                                      child: InkWell(

                                        child: Container(
                                          height: 40,

                                          decoration: BoxDecoration(
                                            color: ColorManager.primary,
                                            borderRadius: BorderRadius.circular(20),

                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:  [
                                                const Image(

                                                  image: AssetImage('icons/hammar.png'),
                                                  height: 25,
                                                  width: 25,
                                                ),
                                                const SizedBox(width: 12,),
                                                Text(
                                                  AppLocalization.of(context).translate('Add')!,
                                                  style: bottomNavIconTextStyle,
                                                ),
                                                const SizedBox(width: 12,),
                                                Text(
                                                  AppLocalization.of(context).translate('Bidding')!,
                                                  style: bottomNavIconTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: (){
                                          cubit.increaseHighestPrice();
                                          if(int.parse(cubit.bidValueController.text)<10000){
                                            Alert(
                                                context: context,
                                                title: 'من فضلك ادخل رقم لا يقل عن 10000'
                                            ).show();
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
                  );
                },

              ),
            ),







          ],

        ),
      ),

    );
  }
}
