import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:kayish/blocs/deals%20detais%20cubit/cubit.dart';
import 'package:kayish/blocs/deals%20detais%20cubit/states.dart';
import 'package:kayish/blocs/profile%20cubit/cubit.dart';
import 'package:kayish/models/deals_details_model.dart';

import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/widgets/deals_bids_item.dart';
import 'package:kayish/widgets/default_button.dart';

class BidsScreen extends StatelessWidget {
  int id;
  BidsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DealsDetailsCubit()..getAuctionDetails(auctionId: id),
      child: BlocConsumer<DealsDetailsCubit, DealsDetailsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DealsDetailsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalization.of(context).translate('Bids')!,
                style: appBarTitle,
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<List<DealsTenders>>(
                future: cubit.getDealsTendersStream(id),
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return const Center(
                  //     child: CircularProgressIndicator(
                  //       color: Colors.yellow,
                  //     ),
                  //   );
                  // }
                  if (snapshot.hasData) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.dealsDetailsModel!.data!.auctionDetails!
                          .dealsTenders.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DealsBidsItem(
                          // time:
                          //     '${DateTime.parse(cubit.all[index].time!).hour} : ${DateTime.parse(cubit.all[index].time!).minute} : ${DateTime.parse(cubit.all[index].time!).second}',
                          // date:
                          //     '${DateTime.parse(cubit.all[index].time!).day} / ${DateTime.parse(cubit.all[index].time!).month} / ${DateTime.parse(cubit.all[index].time!).year}',
                          //
                          time: cubit.dealsDetailsModel!.data!.auctionDetails!
                              .dealsTenders[index].createdAt!
                              .substring(11, 19),
                          date: cubit.dealsDetailsModel!.data!.auctionDetails!
                              .dealsTenders[index].createdAt!
                              .substring(0, 10),
                          lastPrice: cubit.dealsDetailsModel!.data!
                              .auctionDetails!.dealsTenders[index].value
                              .toString(),
                          name: cubit.dealsDetailsModel!.data!.auctionDetails!
                              .dealsTenders[index].name
                              .toString(),
                        ),
                      ),
                      separatorBuilder: (context, index) => Container(
                        height: 2,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.yellow,
                    ),
                  );

                  //   Center(
                  //   child: Text(
                  //     AppLocalization.of(context)
                  //         .translate('There are no bids yet')!,
                  //     style: Styles.getBoldMainTextStyle(
                  //         color: Colors.black, fontSize: FontSize.s18),
                  //   ),
                  // );
                },
              ),

              // StreamBuilder<List<DealsTenders>>(
              //   stream: cubit.getDealsTendersStream(id),
              //   builder: (context, snapshot) {
              //     // if (snapshot.connectionState == ConnectionState.waiting) {
              //     //   return const Center(
              //     //     child: CircularProgressIndicator(
              //     //       color: Colors.yellow,
              //     //     ),
              //     //   );
              //     // }
              //     if (snapshot.hasData) {
              //       return ListView.separated(
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: cubit.dealsDetailsModel!.data!.auctionDetails!
              //             .dealsTenders.length,
              //         itemBuilder: (context, index) => Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: DealsBidsItem(
              //             // time:
              //             //     '${DateTime.parse(cubit.all[index].time!).hour} : ${DateTime.parse(cubit.all[index].time!).minute} : ${DateTime.parse(cubit.all[index].time!).second}',
              //             // date:
              //             //     '${DateTime.parse(cubit.all[index].time!).day} / ${DateTime.parse(cubit.all[index].time!).month} / ${DateTime.parse(cubit.all[index].time!).year}',
              //             //
              //             time: '12:12:12',
              //             date: "12/12/12",
              //             lastPrice: cubit.dealsDetailsModel!.data!
              //                 .auctionDetails!.dealsTenders[index].value
              //                 .toString(),
              //             name: cubit.dealsDetailsModel!.data!.auctionDetails!
              //                 .dealsTenders[index].name
              //                 .toString(),
              //           ),
              //         ),
              //         separatorBuilder: (context, index) => Container(
              //           height: 2,
              //           width: double.infinity,
              //           color: Colors.grey.shade200,
              //         ),
              //       );
              //     }
              //     return Center(
              //       child: Text(
              //         AppLocalization.of(context)
              //             .translate('There are no bids yet')!,
              //         style: Styles.getBoldMainTextStyle(
              //             color: Colors.black, fontSize: FontSize.s18),
              //       ),
              //     );
              //   },
              // ),
            ),
            // SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(32.0),
            //         child: Conditional.single(
            //           context: context,
            //           conditionBuilder:(context)=> cubit.all.isNotEmpty,
            //           widgetBuilder: (context)=> ListView.separated(
            //             shrinkWrap: true,
            //             physics: NeverScrollableScrollPhysics(),
            //             itemCount: cubit.all.length,
            //             itemBuilder: (context,index)=>DealsBidsItem(
            //               time: '${DateTime.parse(cubit.all[index].time!).hour} : ${DateTime.parse(cubit.all[index].time!).minute} : ${DateTime.parse(cubit.all[index].time!).second}',
            //               date: '${DateTime.parse(cubit.all[index].time!).day} / ${DateTime.parse(cubit.all[index].time!).month} / ${DateTime.parse(cubit.all[index].time!).year}',
            //               lastPrice:cubit.all[index].bidValue,
            //             ),
            //             separatorBuilder: (context,index)=>SizedBox(height: 4,),
            //           ),
            //           fallbackBuilder: (context)=>Center(
            //             child: Text(
            //               AppLocalization.of(context).translate('There are no bids yet')!,
            //               style: Styles.getBoldMainTextStyle(color: Colors.black,fontSize: FontSize.s18),
            //             ),
            //           )
            //         ),
            //       ),
            //       SizedBox(height: 16,),
            //
            //     ],
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
