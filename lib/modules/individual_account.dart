import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/cubit.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/states.dart';
import 'package:kayish/models/city_model.dart';
import 'package:kayish/shared/component/font_manager.dart';

import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';
import 'package:kayish/widgets/default_button.dart';
import 'package:kayish/widgets/default_form_field.dart';
import 'package:kayish/widgets/drop_down_menu_item.dart';
import 'package:kayish/widgets/multi_selected_item.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';



import 'account_verification_request_screen.dart';

class IndividualAccountScreen extends StatelessWidget {
  GlobalKey<FormState> indKey= GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    var cubit = AccountVerificationCubit.get(context);
    return BlocConsumer<AccountVerificationCubit, AccountVerificationStates>(
      listener: (context, state) {
        if(state is AccountVerificationSuccessfulState){
          navigateAndFinish(context: context, nextScreen: AccountVerificationRequest());
        }

      },
      builder: (context, state) {
        return Form(
          key: indKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset.zero,
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalization.of(context).translate('Required data')!,
                      style: appBarTitle,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DefaultFormField(
                      obscureText: false,
                      astric: false,
                         inputFormatter: [
                           FilteringTextInputFormatter.deny(RegExp("[0-9]")),
                         ],
                      labelString: 'Full name',
                      hintText: 'please enter your full name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalization.of(context)
                              .translate('please enter your full name');
                        }
                        else if(value.length<5){
                          return AppLocalization.of(context).translate('Please enter at least 5 character');
                        }
                        return null;
                      },
                      controller: cubit.fullNameController,
                      inputType: TextInputType.text,
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    DefaultFormField(
                      isNum: true,
                      inputFormatter: [  LengthLimitingTextInputFormatter(10),],
                      obscureText: false,
                      astric: false,
                      labelString: 'Id number',
                      hintText: 'please enter your id name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalization.of(context)
                              .translate('please enter your national ID');
                        }
                        else if(value.length<10){
                          return AppLocalization.of(context).translate('Please enter 10 numbers');
                        }
                        return null;
                      },
                      controller: cubit.idIndvController,
                      inputType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppLocalization.of(context)
                          .translate('Cities you want to buy from')!,
                      style: const TextStyle(
                          fontFamily: 'GE',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: MultiSelectedItem(
                       selectedOptionsIds: cubit.indSelectedOptionsIds,
                        selectedOptions: cubit.indSelectedOptions,
                        unSelectedOptions: cubit.indUnSelectedOptions,
                      ),
                    ),



                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppLocalization.of(context).translate('Attach work permit')!,
                      style: const TextStyle(
                          fontFamily: 'GE',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          elevation: 4,

                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                          ),
                          context: context,
                          builder: (context)=>Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    child: Text(
                                      AppLocalization.of(context).translate('Camera')!,
                                      style: Styles.getBoldMainTextStyle(color: Colors.black,fontSize: FontSize.s18),
                                    ),
                                    onPressed: (){
                                      Navigator.pop(context);
                                      cubit.checkPermissionOpenCamera(1);



                                    },
                                  ),

                                ),
                                Expanded(

                                  child: TextButton(
                                    child: Text(
                                      AppLocalization.of(context).translate('Gallery')!,
                                      style: Styles.getBoldMainTextStyle(color: Colors.black,fontSize: FontSize.s18),
                                    ),
                                    onPressed: (){
                                      Navigator.pop(context);
                                      cubit.checkPermissionOpenPhoto(1);

                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120,
                            child: Center(
                              child: Image(
                                height: 90,
                                width: 90,
                                image: AccountVerificationCubit.get(context)
                                            .workPremitINdv ==
                                        null
                                    ? const AssetImage(
                                        'images/id.png',
                                      )
                                    : Image.file(
                                            AccountVerificationCubit.get(context)
                                                .workPremitINdv!
                                                )
                                        .image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black)),
                          ),
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              color: Colors.black45.withOpacity(.4),
                            ),
                            width: double.infinity,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              backgroundColor: Colors.black54,
                              radius: 25,
                              child: FittedBox(
                                child: Image(
                                  height: 25,
                                  width: 25,
                                  image: AssetImage('icons/camera.png'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 30,
                        width: double.infinity,
                        child: TextFormField(
                           readOnly: true,
                          decoration: const InputDecoration(
                              border: InputBorder.none
                          ),
                          validator: (value){
                            if(cubit.workPremitINdv==null){
                              return AppLocalization.of(context).translate('Please pick image');
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if(state is !AccountVerificationLoadingState)
                    DefaultButton(
                      onPressed: () {
                        if(indKey.currentState!.validate()){
                          if(cubit.indSelectedOptionsIds.isEmpty){
                            for(var element in cubit.insUnSelectedOptions){
                              cubit.indSelectedOptionsIds.add(element.id!);
                            }
                          }
                         cubit.postAccountVerification(
                           type: '1',
                           name: cubit.fullNameController.text,
                           workingLicenceImage: cubit.workPremitINdv!,
                           personalId: cubit.idIndvController.text,
                           city: cubit.indSelectedOptionsIds
                         );
                        }

                      },
                      text: 'Send',
                    ),
                    if(state is AccountVerificationLoadingState)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyCircularPrograssIndicator(),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
