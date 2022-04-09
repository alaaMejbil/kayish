import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;
  Map<String,String>? _localizedString;
  AppLocalization(this.locale);

 static AppLocalization of(BuildContext context){
   return Localizations.of<AppLocalization>(context, AppLocalization)!;
 }
 static  LocalizationsDelegate <AppLocalization> delegate=AppLocalizationDelegate();


 Future<bool> load()async{
  String jsonString= await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String,dynamic>myMap= json.decode(jsonString);
    _localizedString=myMap.map<String,String>((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
 }

 String? translate(String key){
   return _localizedString![key];
 }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization>{

  @override
  bool isSupported(Locale locale) {
    return['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale)async {
    AppLocalization appLocalization=AppLocalization(locale);
    await appLocalization.load();
    return appLocalization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
  
}