import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/policy%20cubit/states.dart';
import 'package:kayish/models/policy_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';

class PolicyCubit extends Cubit<PolicyStates> {
  PolicyCubit() : super(PolicyInitialState());

  static PolicyCubit get(context) => BlocProvider.of(context);
  PolicyModel? policyModel;
  void getPolicy() {
    emit(PolicyLoadingState());
    DioHelper.getData(
      url: 'policy',
      headers: {
        'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar'
      },
    ).then((value) {
      if (value.statusCode == 200) {
        policyModel = PolicyModel.fromMap(value.data);
        if (policyModel!.modelState == 1) {
          emit(PolicySuccessfulState());
        } else {
          emit(PolicyErrorDataInputState());
        }
      }
    }).catchError((onError) {
      print(onError);
      emit(PolicyErrorState());
    });
  }
}
