import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/blocs/home%20cubit/states.dart';

import 'package:kayish/blocs/sort%20cubit/sort_states.dart';
import 'package:kayish/blocs/sort%20cubit/sort_cubit.dart';
import 'package:kayish/models/city_model.dart';
import 'package:kayish/models/district_city_model.dart';
import 'package:kayish/models/real_state_model.dart';
import 'package:kayish/models/region_model.dart';

import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';
import 'package:kayish/widgets/default_button.dart';
import 'package:kayish/widgets/drop%20down.dart';
import 'package:kayish/widgets/drop_down_menu_item.dart';
import 'package:kayish/widgets/multi_selected_item.dart';



import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SortScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    CasheHelper.putData(key: 'screen name', value: 'sort');
    return BlocProvider(
      create: (context) => SortCubit()..getRegion()..getCity(1)..getDistrictCity(1)..getRealStateType(),
      child: BlocConsumer<SortCubit, SortStates>(
        listener: (context, state) {
         if(state is ChangeRegionState){
           SortCubit.get(context).getCity(SortCubit.get(context).selectedRegion!.id!);

         }
         if(state is ChangeCityState){
           SortCubit.get(context).getDistrictCity(SortCubit.get(context).selectedCity!.id!);
         }
        },
        builder: (context, state) {
          var cubit = SortCubit.get(context);



          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalization.of(context).translate('Sort')!,
                  style: appBarTitle),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                  HomeCubit.get(context).getHomeData(cityId: 0,regionId: 0,districtId: 0,realStateTypeId: 0);
                },
              ),
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context)=>cubit.isLoading==false,
              widgetBuilder: (context)=>cubit.regionModel!=null&&cubit.cityModel!=null&&cubit.districtCityModel!=null&&cubit.realStateModel!=null?SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top:8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [

                        DropDown<Region>(
                          value:cubit.selectedRegion,
                          title: 'By region',
                          listValue:cubit.regionModel!.data!.regions ,

                          onChange: (value){
                            cubit.selectRegion(value!);

                          },

                        ),
                        const SizedBox(height: 4,),
                        DropDown<City>(
                          value:cubit.selectedCity,
                          title: 'City',
                          listValue:cubit.cityModel!.data!.cities ,

                          onChange: (value){
                            cubit.selectCity(value!);

                          },

                        ),
                        const SizedBox(height: 4,),
                        DropDown<District>(
                          value:cubit.selectedDistrictCity,
                          title: 'Neighborhood',
                          listValue:cubit.districtCityModel!.data!.districts  ,

                          onChange: (value){
                            cubit.selectDistrictCity(value!);
                          },

                        ),
                        const SizedBox(height: 4,),
                        DropDown<RealEstateType>(
                          value:cubit.selectedRealEstateType,
                          title: 'Estate Type',
                          listValue: cubit.realStateModel!.data!.realEstateType  ,

                          onChange: (value){
                           cubit.selectBuildType(value!);
                          },

                        ),
                        const SizedBox(height: 4,),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 16, top: 8, right: 16),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalization.of(context)
                                      .translate('Estate Duration')!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                  height: 28,
                                  child: TextFormField(
                                    controller: cubit.propertyAge,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(RegExp("[a-zA-Z]")),
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsetsDirectional.only(bottom: 12),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      hintText: '1',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4,),
                        // DropDown<String>(
                        //   value:cubit.auctionState,
                        //   title: 'Auction Status',
                        //   listValue:['جاري','منتهي','قادم']  ,
                        //
                        //   onChange: (value){
                        //     cubit.selectAuctionState(value!);
                        //   },
                        //
                        // ),


                      ]      //
                  ),
                ),

              ):
              Center(
                child: Text(
                  AppLocalization.of(context).translate('No content')!,
                  style: Styles.getBoldMainTextStyle(color: Colors.black,fontSize: FontSize.s20),
                ),
              ),
              fallbackBuilder:(context)=> Center(child: MyCircularPrograssIndicator()),

            ),
            floatingActionButton: BlocConsumer<HomeCubit,HomeStates>(
              listener: (context,state)=>{
                if(state is HomeSuccessfulState){
                  Navigator.pop(context)
                }
              },
              builder: (context,state){
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child:HomeCubit.get(context).isLoading==false?DefaultButton(
                      text: 'Display Results',
                      width: 150,
                      gradiant: LinearGradient(
                        colors: [
                          ColorManager.darkYellow.withOpacity(.8),
                          ColorManager.darkYellow
                        ],
                      ),
                      textColor: Colors.white,
                      onPressed: () {

                        HomeCubit.get(context).getHomeData(cityId: cubit.selectedCity!.id,regionId:cubit.selectedRegion!.id,districtId: cubit.selectedDistrictCity!.id,realStateTypeId: cubit.selectedRealEstateType!.id,age: cubit.propertyAge.text ,);



                      },
                    ):Padding(
                      padding: const EdgeInsetsDirectional.only(end:60),
                      child: MyCircularPrograssIndicator(),
                    )
                );
              },

            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
          );
        },
      ),
    );
  }
}
