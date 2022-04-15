import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kayish/blocs/logout%20cubit/states.dart';
import 'package:kayish/models/logout_model.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/shared/network/remote/dio_helper.dart';
import 'package:kayish/utils/utils.dart';

class LogoutCubit extends Cubit<LogoutStates> {
  LogoutCubit() : super(LogoutInitialState());
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: IOSAccessibility.unlocked,
    ),
  );
  static LogoutCubit get(context) => BlocProvider.of(context);
  LogoutModel? logoutModel;

  void logout() {
    emit(LogoutLoadingStateState());
    DioHelper.getData(url: 'logout', headers: {
      'lang': CasheHelper.getData(key: 'isArabic') == false ? 'en' : 'ar',
      'Authorization': 'bearer ${CasheHelper.getData(key: token)}',
    }).then((value) async {
      CasheHelper.removeData(key: token);

      print('${CasheHelper.getData(key: token)}');
      await FirebaseAuth.instance.signOut();
      emit(LogoutSuccessfulState());
    }).catchError((onError) {
      print(onError);
      emit(LogoutErrorState());
    });
  }
}
