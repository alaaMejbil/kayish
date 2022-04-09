import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class BuildDescriptionItem extends StatelessWidget {
 String? name ;
 String? value;
 BuildDescriptionItem({
   this.value,
   this.name
});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 1,
                    blurRadius: 3
                ),
              ]
          ),
          child: Center(
            child: Text(
              value!,
              textAlign: TextAlign.center,
              style: detailsTextStyle,
            ),
          ),
        ),
        const SizedBox(height: 4,),
        Text(
         name! ,
          style: bidsTextStyle,
        ),
      ],
    );
  }
}
