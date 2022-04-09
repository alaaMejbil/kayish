import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/cubit.dart';
import 'package:kayish/blocs/app%20cubit/app_cubit.dart';
import 'package:kayish/blocs/app%20cubit/app_states.dart';
import 'package:kayish/blocs/code%20verification%20cubit/cubit.dart';
import 'package:kayish/blocs/code%20verification%20cubit/cubit.dart';
import 'package:kayish/blocs/deals%20detais%20cubit/cubit.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';

import 'package:kayish/blocs/layout%20cubit/layout_cubit.dart';

import 'package:kayish/blocs/policy%20cubit/cubit.dart';
import 'package:kayish/blocs/profile%20cubit/cubit.dart';

import 'package:kayish/blocs/sign%20in%20cubit/cubit.dart';
import 'package:kayish/blocs/sign%20up%20cubit/cubit.dart';
import 'package:kayish/blocs/sort%20cubit/sort_cubit.dart';

import 'package:kayish/modules/splash_screen.dart';

import 'package:kayish/shared/component/color_manager.dart';

import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:flutter/services.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:overlay_support/overlay_support.dart';

import '../shared/component/date_functions.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  MaterialColor color = const MaterialColor(0xFFC8C91E, {
    50: Color(0xFFC8C91E),
    100: Color(0xFFC8C91E),
    200: Color(0xFFC8C91E),
    300: Color(0xFFC8C91E),
    400: Color(0xFFC8C91E),
    500: Color(0xFFC8C91E),
    600: Color(0xFFC8C91E),
    700: Color(0xFFC8C91E),
    800: Color(0xFFC8C91E),
    900: Color(0xFFC8C91E),
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainLayoutCubit()..listenOnNetwork()),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => SortCubit()..getRegion()),
        BlocProvider(
            create: (context) => AccountVerificationCubit()..getCity()),
        BlocProvider(create: (context) => DealsDetailsCubit()),
        BlocProvider(create: (context) => PolicyCubit()..getPolicy()),
        BlocProvider(create: (context) => ProfileCubit()..getProfile()),
        BlocProvider(create: (context) => VerificationCodeCubit()),
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);

          return OverlaySupport.global(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: color,
                primaryColor: ColorManager.primary,
              ),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalization.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ar', 'EG'),
              ],
              locale: CasheHelper.getData(key: 'isArabic') == false
                  ? const Locale('en', 'US')
                  : const Locale('ar', 'EG'),
              home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
