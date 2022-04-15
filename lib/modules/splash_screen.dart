import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/modules/welcome_screen.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';

import '../shared/component/date_functions.dart';
import 'layout_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Timer> startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    print('first=======>${CasheHelper.getData(key: 'first')}');
    if (CasheHelper.getData(key: 'first') == null) {
      navigateAndFinish(context: context, nextScreen: WelcomeScreen());
    } else {
      navigateToLast(context);
    }
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/Intro.png'), fit: BoxFit.fill)),
      ),
    );
  }
}
