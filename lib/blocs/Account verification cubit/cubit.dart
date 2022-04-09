import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/states.dart';
import 'package:kayish/blocs/code%20verification%20cubit/states.dart';
import 'package:kayish/models/account_verification_model.dart';
import 'package:kayish/models/city_model.dart';
import 'package:kayish/modules/individual_account.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class AccountVerificationCubit extends Cubit<AccountVerificationStates> {
  AccountVerificationCubit() : super(AccountInitialState());

  static AccountVerificationCubit get(context) => BlocProvider.of(context);

  //institution screen
  TextEditingController tradeNameController = TextEditingController();
  TextEditingController tradeNumberController = TextEditingController();
  TextEditingController idInstController = TextEditingController();

  // indvidual screen{
  TextEditingController idIndvController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  int currentIndex = 0;
  //}

  File? workPremitInst;
  File? logImage;
  File? workPremitINdv;
  City? selectedCity;

  List<City> indSelectedOptions = [];
  List<City> indUnSelectedOptions = [];
  List<int> indSelectedOptionsIds = [];

  List<City> insSelectedOptions = [];
  List<City> insUnSelectedOptions = [];
  List<int> insSelectedOptionsIds = [];

  void changeCurrentIndex(value) {
    currentIndex = value;
    emit(ChangeCurrentIndexState());
  }

  void changeSelectedCity(City value) {
    selectedCity = value;
    emit(ChangeSelectedCity());
  }

  void workPremitPick(int imageNum, ImageSource source) {
    ImagePicker _picker = ImagePicker();

    // Pick an image
    _picker.pickImage(source: source).then((value) {
      if (imageNum == 1) {
        workPremitINdv = File(value!.path);

        emit(PickWorkPremitState());
      } else if (imageNum == 2) {
        workPremitInst = File(value!.path);

        emit(PickWorkPremitState());
      } else {
        logImage = File(value!.path);

        emit(PickWorkPremitState());
      }
    });
  }

  //camera permission;
  void checkPermissionOpenCamera(int imageNum) {
    Permission.camera.status.then((value) {
      print(value);
      if (value.isGranted) {
        workPremitPick(imageNum, ImageSource.camera);

        emit(CameraPermissionGranted());
      } else if (!value.isGranted) {
        Permission.camera.request().then((value) {
          if (value.isGranted) {
            workPremitPick(imageNum, ImageSource.camera);
          } else {
            Permission.camera.request().isDenied;
          }
        });
        emit(CameraPermissionDenied());
      }
    }).catchError((onError) {
      print(onError);
      emit(CameraPermissionError());
    });
  }

  //gallery permission
  void checkPermissionOpenPhoto(int imageNum) {
    Permission.photos.status.then((value) {
      print(value);
      if (value.isGranted) {
        workPremitPick(imageNum, ImageSource.gallery);
        emit(PhotoPermissionGranted());
      } else if (!value.isGranted) {
        Permission.camera.request();
        emit(PhotoPermissionDenied());
      }
    }).catchError((onError) {
      print(onError);
      emit(PhotoPermissionError());
    });
  }

  AccountVerificationModel? accountVerificationModel;

  // type =1 for user info
  //type=2 for company info
  void postAccountVerification(
      {required String type,
      required String name,
      required File workingLicenceImage,
      required String personalId,
      required List<int> city,
      String? commericalNumber,
      File? commericalLicenceImage}) async {
    emit(AccountVerificationLoadingState());

    DioHelper.postFormData(
        url: 'accountVerification',
        headers: {
          'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
          'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
        },
        data: FormData.fromMap({
          'type': type,
          'name': name,
          'personalId': personalId,
          'city[]': city,
          'working_license': await MultipartFile.fromFile(
              workingLicenceImage.path,
              filename: workingLicenceImage.path),
          'commercial_Register_No': commericalNumber ?? '',
          'commercial_license': commericalLicenceImage != null
              ? await MultipartFile.fromFile(workingLicenceImage.path,
                  filename: workingLicenceImage.path)
              : '',
        })).then((value) {
      if (value.statusCode == 200) {
        print(value.data['message']);
        accountVerificationModel = AccountVerificationModel.fromMap(value.data);
        if (accountVerificationModel!.modelState == 1) {
          emit(AccountVerificationSuccessfulState());
        } else {
          emit(AccountVerificationErrorDataInputState());
        }
      }
    }).catchError((onError) {
      print('==============>$onError');
      emit(AccountVerificationErrorState());
    });
  }

  CityModel? cityModel;

  void getCity() {
    DioHelper.getData(
      url: 'region_cities',
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar'
      },
    ).then((value) {
      if (value.statusCode == 200) {
        cityModel = CityModel.fromMap(value.data);
        if (cityModel!.modelState == 1) {
          indUnSelectedOptions.addAll(cityModel!.data!.cities);
          insUnSelectedOptions.addAll(cityModel!.data!.cities);
          emit(CitySuccessState());
        } else {}
      }
    }).catchError((onError) {
      print(onError);
      emit(CityErrorState());
    });
  }
}
