

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCircularPrograssIndicator extends StatelessWidget {
  Color? color;
  Color? backGroundColor;

  MyCircularPrograssIndicator({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid) {
      return CircularProgressIndicator(
        backgroundColor: backGroundColor,
        color: color,
      );
    }
      else{
       return CupertinoActivityIndicator(
         color: color,

       );
    }
    }
  }

