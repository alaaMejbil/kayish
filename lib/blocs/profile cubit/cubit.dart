import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/profile%20cubit/states.dart';
import 'package:kayish/models/profile_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit() : super(ProfileInitialState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileModel? profileModel;
  void getProfile(){
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: 'myProfile',
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
        'Authorization': 'bearer ${CasheHelper.getData(key: token)}'
      }
    ).then((value) {
      if(value.statusCode==200){
        profileModel=ProfileModel.fromMap(value.data);
        if(profileModel!.modelState==1){
          // print('user status=>${profileModel!.data!.profile!.status!}');
          emit(ProfileSuccessfulState());
        }
        else{
          emit(ProfileErrorDataInputState());
        }
      }

    }).catchError((onError){
      print(onError);
      emit(ProfileErrorState());
    });
  }

}