import 'package:flutter/cupertino.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class ProfileLabel extends StatelessWidget {
   String? title;
   String? value;
   TextStyle? valueTextStyle;
   ProfileLabel({
     required this.title,
     required this.value,
     required this.valueTextStyle,
});

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.center,

      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
           AppLocalization.of(context).translate(title!)! ,
            style:profileLabelTitle
          ),
        ),

        Align(
          alignment: AlignmentDirectional.center,
          child: Text(

            value!,
            textDirection: TextDirection.ltr,
            style: valueTextStyle,
          ),
        ),
      ],
    );
  }
}
