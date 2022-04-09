import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';

int currentAuctionCounter({required int endTime}) {
  Duration countDuration = DateTime.fromMillisecondsSinceEpoch(endTime * 1000)
      .difference(DateTime.now());
  DateTime timeOfDuration = DateTime.now().add(countDuration);
  int myCounter = timeOfDuration.millisecondsSinceEpoch;
  return myCounter;
}

final DatabaseReference reference =
    FirebaseDatabase.instance.ref().child('chat_room');
String? newKey;

// DateTime.fromMillisecondsSinceEpoch(1648228454554 - 1000000).difference(DateTime.now()).inMinutes

String nextAuctionLeftTime(
    {required int adTime, required BuildContext context}) {
  int dateMints = ((DateTime.fromMillisecondsSinceEpoch(adTime * 1000).minute) -
          DateTime.now().minute)
      .abs();
  int dateHours = ((DateTime.fromMillisecondsSinceEpoch(adTime * 1000).hour) -
          DateTime.now().hour)
      .abs();
  int dateDays = ((DateTime.fromMillisecondsSinceEpoch(adTime * 1000).day) -
          DateTime.now().day)
      .abs();
  int dateMonth = ((DateTime.fromMillisecondsSinceEpoch(adTime * 1000).month) -
          DateTime.now().month)
      .abs();
  int dateYear = ((DateTime.fromMillisecondsSinceEpoch(adTime * 1000).year) -
          DateTime.now().year)
      .abs();
  if (CasheHelper.getData(key: 'isArabic') == false) {
    // NOW
    if (dateMints == 0) {
      return AppLocalization.of(context).translate('now').toString();
    }

    /// 4 days ago
    if (dateDays != 0 && dateDays <= 31) {
      return "${(dateDays != 2) ? dateDays : ''} ${AppLocalization.of(context).translate((dateDays == 1) ? 'day' : (dateDays == 2) ? 'twoDays' : (dateDays > 2 && dateDays <= 10) ? 'days' : 'day').toString()} ${AppLocalization.of(context).translate('Left').toString()}";
    }

    /// 4 years ago
    if (dateYear != 0) {
      return "${AppLocalization.of(context).translate((dateYear == 1) ? 'year' : (dateYear == 2) ? 'twoYears' : (dateYear > 2 && dateYear <= 10) ? 'years' : 'year').toString()} ${AppLocalization.of(context).translate('Left').toString()} ${(dateYear != 2) ? dateYear : ''}";
    }

    /// 4 month ago
    if (dateMonth != 0 && dateMonth <= 12) {
      return "${(dateMonth != 2) ? dateMonth : ''} ${AppLocalization.of(context).translate((dateMonth == 1) ? 'month' : (dateMonth == 2) ? 'twoMonths' : (dateMonth > 2 && dateMonth <= 10) ? 'months' : 'month').toString()} ${AppLocalization.of(context).translate('Left').toString()}";
    }

    /// 4 hours ago
    if (dateHours != 0) {
      return "${(dateHours != 2) ? dateHours : ''} ${AppLocalization.of(context).translate((dateHours == 1) ? 'hour' : (dateHours == 2) ? 'twoHours' : (dateHours > 2 && dateHours <= 10) ? 'hours' : 'hour').toString()} ${AppLocalization.of(context).translate('Left').toString()}";
    }

    /// 4 minutes ago
    else {
      return "${(dateMints != 2) ? dateMints : ''} ${AppLocalization.of(context).translate((dateMints == 1) ? 'minute' : (dateMints == 2) ? 'twoMinutes' : (dateMints > 2 && dateMints <= 10) ? 'minutes' : 'minute').toString()} ${AppLocalization.of(context).translate('Left').toString()}";
    }
  } else {
    if (dateMints == 0) {
      return AppLocalization.of(context).translate('now').toString();
    }

    /// 4 days ago
    if (dateDays != 0 && dateDays <= 31) {
      return "${AppLocalization.of(context).translate('Left').toString()} ${(dateDays != 2) ? dateDays : ''} ${AppLocalization.of(context).translate((dateDays == 1) ? 'day' : (dateDays == 2) ? 'twoDays' : (dateDays > 2 && dateDays <= 10) ? 'days' : 'day').toString()}";
    }

    /// 4 years ago
    if (dateYear != 0) {
      return "${AppLocalization.of(context).translate('Left').toString()} ${(dateYear != 2) ? dateYear : ''} ${AppLocalization.of(context).translate((dateYear == 1) ? 'year' : (dateYear == 2) ? 'twoYears' : (dateYear > 2 && dateYear <= 10) ? 'years' : 'year').toString()}";
    }

    /// 4 month ago
    if (dateMonth != 0 && dateMonth <= 12) {
      return "${AppLocalization.of(context).translate('Left').toString()} ${(dateMonth != 2) ? dateMonth : ''} ${AppLocalization.of(context).translate((dateMonth == 1) ? 'month' : (dateMonth == 2) ? 'twoMonths' : (dateMonth > 2 && dateMonth <= 10) ? 'months' : 'month').toString()}";
    }

    /// 4 hours ago
    if (dateHours != 0) {
      return "${AppLocalization.of(context).translate('Left').toString()} ${(dateHours != 2) ? dateHours : ''} ${AppLocalization.of(context).translate((dateHours == 1) ? 'hour' : (dateHours == 2) ? 'twoHours' : (dateHours > 2 && dateHours <= 10) ? 'hours' : 'hour').toString()}";
    }

    /// 4 minutes ago
    else {
      return "${AppLocalization.of(context).translate('Left').toString()} ${(dateMints != 2) ? dateMints : ''} ${AppLocalization.of(context).translate((dateMints == 1) ? 'minute' : (dateMints == 2) ? 'twoMinutes' : (dateMints > 2 && dateMints <= 10) ? 'minutes' : 'minute').toString()}";
    }
  }
}

String nextAuctionLeftTime2(
    {required int adTime, required BuildContext context}) {
  int min = DateTime.fromMillisecondsSinceEpoch(1648228454554 - 1000000)
      .difference(DateTime.now())
      .inMinutes;

  if (min == 0) {
    //return AppLocalization.of(context).translate('now').toString();
  } else if (min > 1) {
  } else if (min < 0) {}

  int dateMints = DateTime.fromMillisecondsSinceEpoch(adTime)
      .difference(DateTime.now())
      .inMinutes;
  int dateHours = DateTime.fromMillisecondsSinceEpoch(adTime)
      .difference(DateTime.now())
      .inHours;
  int dateDays = DateTime.fromMillisecondsSinceEpoch(adTime)
      .difference(DateTime.now())
      .inDays;

  print('dateMints is: $dateMints');
  print('dateHours is: $dateHours');
  print('dateDays is: $dateDays');

  if (CasheHelper.getData(key: 'isArabic') == false) {
    // NOW
    if (dateMints == 0) {
      return AppLocalization.of(context).translate('now').toString();
    }

    /// 4 days ago
    if (dateDays != 0 && dateDays <= 31) {
      return "${(dateDays != 2) ? dateDays : ''} ${AppLocalization.of(context).translate((dateDays == 1) ? 'day' : (dateDays == 2) ? 'twoDays' : (dateDays > 2 && dateDays <= 10) ? 'days' : 'day').toString()} ${AppLocalization.of(context).translate('Left').toString()}";
    }

    /// 4 hours ago
    if (dateHours != 0) {
      return "${(dateHours != 2) ? dateHours : ''} ${AppLocalization.of(context).translate((dateHours == 1) ? 'hour' : (dateHours == 2) ? 'twoHours' : (dateHours > 2 && dateHours <= 10) ? 'hours' : 'hour').toString()} ${AppLocalization.of(context).translate('Left').toString()}";
    }

    /// 4 minutes ago
    else {
      return "${(dateMints != 2) ? dateMints : ''} ${AppLocalization.of(context).translate((dateMints == 1) ? 'minute' : (dateMints == 2) ? 'twoMinutes' : (dateMints > 2 && dateMints <= 10) ? 'minutes' : 'minute').toString()} ${AppLocalization.of(context).translate('Left').toString()}";
    }
  } else {
    if (dateMints == 0) {
      return AppLocalization.of(context).translate('now').toString();
    }

    /// 4 days ago
    if (dateDays != 0 && dateDays <= 31) {
      return "${AppLocalization.of(context).translate('Left').toString()} ${(dateDays != 2) ? dateDays : ''} ${AppLocalization.of(context).translate((dateDays == 1) ? 'day' : (dateDays == 2) ? 'twoDays' : (dateDays > 2 && dateDays <= 10) ? 'days' : 'day').toString()}";
    }

    /// 4 hours ago
    if (dateHours != 0) {
      return "${AppLocalization.of(context).translate('Left').toString()} ${(dateHours != 2) ? dateHours : ''} ${AppLocalization.of(context).translate((dateHours == 1) ? 'hour' : (dateHours == 2) ? 'twoHours' : (dateHours > 2 && dateHours <= 10) ? 'hours' : 'hour').toString()}";
    }

    /// 4 minutes ago
    else {
      return "${AppLocalization.of(context).translate('Left').toString()} ${(dateMints != 2) ? dateMints : ''} ${AppLocalization.of(context).translate((dateMints == 1) ? 'minute' : (dateMints == 2) ? 'twoMinutes' : (dateMints > 2 && dateMints <= 10) ? 'minutes' : 'minute').toString()}";
    }
  }
}

String notificationDate(int timeInEpoch) {
  String date =
      '${DateTime.fromMillisecondsSinceEpoch(timeInEpoch * 1000).day}/${DateTime.fromMillisecondsSinceEpoch(timeInEpoch * 1000).month}';
  return date;
}

String notificationTime(int timeInEpoch) {
  String time1 = DateFormat.jm()
      .format(DateTime.fromMillisecondsSinceEpoch(timeInEpoch * 1000));
  return time1;
}
