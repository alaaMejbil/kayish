import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/font_manager.dart';

import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

import 'defualt_text.dart';
import 'package:flutter/services.dart';

class DefaultFormField extends StatelessWidget{
  String? hintText;
  bool? obscureText;
  String? labelString;
  TextInputType? inputType;
  FormFieldValidator<String>? validator;
  TextEditingController? controller;
  bool? astric;
  bool? isNum;

  TextDirection? textDirection;
  List<TextInputFormatter>? inputFormatter;
  DefaultFormField({
   required this.hintText,
    this.obscureText=false,
    required this.validator,
    required this.labelString,
   required this.controller,
    this.inputType,
    this.astric=true,
    this.isNum=true,
    this.inputFormatter,
    this.textDirection,
});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(

          children: [
            DefaultText(

              myText: AppLocalization.of(context).translate(labelString!),
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'GE',
                fontWeight: FontWeight.w700,
                color: Colors.black
              ),
            ),
            if(astric==true)
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(
                Icons.star,color: Colors.red,size: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4,),
        TextFormField(

         textDirection: textDirection,
          inputFormatters: inputFormatter,
          obscureText:obscureText!,
          controller: controller,
          validator: validator,
           cursorHeight: 20,
          keyboardType:inputType ,



          decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.only(top: 4,start: 12),
            hintText: AppLocalization.of(context).translate(hintText!),

            hintStyle:  TextStyle(
              color: Colors.grey.shade500,
              fontSize: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),

            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:  BorderSide(color: Colors.grey.shade500),

            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:  const BorderSide(color: ColorManager.primary),

            ),
          ),
        ),
      ],
    );
  }

}