import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class HeadItem extends StatelessWidget {
 String? head;
 GestureTapCallback? onTab;
 HeadItem({
   required this.head,
   required this.onTab
});


  @override
  Widget build(BuildContext context) {
    return Row(


      children: [
        Text(
          AppLocalization.of(context).translate(head!)!,
          style: headItemTextStyle,
        ),
        const Spacer(),
        InkWell(
          onTap: onTab,
          splashColor: ColorManager.primary,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalization.of(context).translate('All')!,
                style: allTextStyle,


              ),
              const Center(child:  Icon(Icons.arrow_forward_ios,color: ColorManager.primary,size: 12,)),


            ],
          ),
        ),
      ],
    );
  }
}
