



import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/sort%20cubit/sort_states.dart';
import 'package:kayish/models/city_model.dart';
import 'package:kayish/models/district_city_model.dart';
import 'package:kayish/models/real_state_model.dart';
import 'package:kayish/models/region_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';


class SortCubit extends Cubit<SortStates> {
  SortCubit() : super(InitialSortState());
  static SortCubit get(context) => BlocProvider.of(context);
  bool isLoading=false;
  Region? selectedRegion;
  City? selectedCity;
  District? selectedDistrictCity;
  RealEstateType? selectedRealEstateType;

  String auctionState='جاري';
  TextEditingController propertyAge=TextEditingController();
//change region value
  selectRegion(Region value){
  selectedRegion=value;

   emit(ChangeRegionState());
  }
  //change city value in dropdown buttom
  selectCity(City value ){
    selectedCity=value;
    emit(ChangeCityState());
  }
  //change district city in dropdown
  selectDistrictCity(District value ){

     selectedDistrictCity=value;
    emit(ChangeNeighbourhoodState());
  }
  //change build type value
  selectBuildType(RealEstateType value){
    selectedRealEstateType=value;
    emit(ChangeEstateTypeState());
  }
  selectAuctionState(String value){
    auctionState=value;
    emit(ChangeAuctionState());
  }
  changeLoadingState(bool value){
    isLoading=value;
    emit(ChangeLoadingState());
  }

  RegionModel? regionModel;

  void getRegion(){
    changeLoadingState(true);
    DioHelper.getData(
      url: 'regions',
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar'
      },

    ).then((value) {
       if(value.statusCode==200){

         regionModel=RegionModel.fromMap(value.data);
         if(regionModel!.modelState==1){

           selectedRegion=regionModel!.data!.regions.first;
           getCity(selectedRegion!.id!);
           emit(RegionSuccessState());
         }
         else selectedRegion!.name='no regions';
       }
    }).catchError((onError){
   print(onError);
   emit(RegionErrorState());
    });
  }

  CityModel? cityModel;
  void getCity(int regionId){
    DioHelper.getData(
      url: 'region_cities?region_id=$regionId',
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar'
      },

    ).then((value) {
      if(value.statusCode==200){

        cityModel=CityModel.fromMap(value.data);
        if(cityModel!.modelState==1){

          selectedCity=cityModel!.data!.cities.first;
          getDistrictCity(selectedCity!.id!);
          emit(CitySuccessState());
        }
        else {
          selectedCity!.name='no cities';
        }
      }
    }).catchError((onError){
      print(onError);
      emit(CityErrorState());
    });
  }

  DistrictCityModel? districtCityModel;

  void getDistrictCity(int cityId){
    DioHelper.getData(
      url: 'City_districts?city_id=$cityId',
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar'
      },

    ).then((value) {
      changeLoadingState(false);
      if(value.statusCode==200){

        districtCityModel=DistrictCityModel.fromMap(value.data);
        if(districtCityModel!.modelState==1){
          selectedDistrictCity=districtCityModel!.data!.districts.first;
          emit(DistrictSuccessState());
        }
        else {
          selectedDistrictCity!.name='no districtcity';
          changeLoadingState(false);
        }
      }
    }).catchError((onError){
      print(onError);
      changeLoadingState(false);

      emit(DistrictErrorState());
    });
  }

    RealStateModel? realStateModel;
  void getRealStateType(){
      DioHelper.getData(
        url: 'realEstateType',
        headers: {
          'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar'
        },
      ).then((value) {
        if(value.statusCode==200){
          realStateModel=RealStateModel.fromMap(value.data);
          selectedRealEstateType=realStateModel!.data!.realEstateType.first;
        }

      }).catchError((onError){
        print(onError);
        emit(RealStateTypeErrorState());
      });
  }
}