import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class PriceTableItem extends StatelessWidget {
  String? title;
  String? price;
  PriceTableItem({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalization.of(context).translate(title!)!,
            style: textButtonStyle.copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 8,
          ),
          const DottedLine(
            dashColor: Colors.blue,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            price!,
            style: detailsTextStyle.copyWith(color: ColorManager.primary),
          ),
        ],
      ),
    );
  }
}
