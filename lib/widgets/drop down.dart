import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/models/city_model.dart';
import 'package:kayish/models/district_city_model.dart';
import 'package:kayish/models/real_state_model.dart';
import 'package:kayish/models/region_model.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class DropDown<T> extends StatefulWidget {
  T? value;
  List<T>? listValue;
  String? title;
  ValueChanged<T?>? onChange;
  DropDown({
    required this.onChange,
    required this.listValue,
    required this.value,
    required this.title,


});

  @override
  State<DropDown<T>> createState() => _DropDownState();
}

class _DropDownState<T> extends State<DropDown<T>> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalization.of(context).translate(widget.title!)!,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          Container(
              height: 28,
              child: DropdownButton<T>(
                isExpanded: true,
                    underline: const SizedBox(),
                    hint: Text(
                      AppLocalization.of(context).translate('No Found')!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                   onChanged: widget.onChange,
                   icon: const Icon(
                     Icons.keyboard_arrow_down_sharp,),
                      value: widget.value,
                        elevation: 1,
                      items:widget.listValue!.map((T e) {

                  return  DropdownMenuItem<T>(

                child: Text(e is Region?e.name!:e is City?e.name!:e is District? e.name!:e is RealEstateType? e.name!:'$e' ) ,
                   value: e

                   );}).toList(),
          ),
          ),
          Container(
            height: 1.3,
            color: Colors.grey[300],
          ),
        ],
      ),
    );

  }


}




