import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/component/styles.dart';

class DealsBidsItem extends StatelessWidget {
  String? lastPrice;
  String? time;
  String? date;
  String? name;
  DealsBidsItem({
    required this.lastPrice,
    required this.time,
    required this.date,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name ?? "",
            textAlign: TextAlign.center,
            style: bidsTextStyle.copyWith(fontSize: 12),
          ),
          SizedBox(
            width: 25,
          ),
          Text(
            lastPrice!,
            textAlign: TextAlign.center,
            style: bidsTextStyle.copyWith(fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Center(
            child: Text(
              time!,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: bidsTextStyle,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Center(
            child: Center(
              child: Text(
                '|',
                textAlign: TextAlign.center,
                style: bidsTextStyle,
              ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Center(
            child: Text(
              date!,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: bidsTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
