import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/cubit.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/states.dart';
import 'package:kayish/models/city_model.dart';
import 'package:kayish/modules/account_verification_request_screen.dart';
import 'package:kayish/shared/component/font_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/component/styles_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';
import 'package:kayish/widgets/default_button.dart';
import 'package:kayish/widgets/default_form_field.dart';
import 'package:kayish/widgets/multi_selected_item.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InstitutionAccountScreen extends StatelessWidget {

  GlobalKey<FormState> insKey= GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AccountVerificationCubit,AccountVerificationStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit = AccountVerificationCubit.get(context);
        return   Form(
          key: insKey,
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
                      labelString:'Trade Name',
                      hintText: 'Please enter your trade name',
                      inputFormatter: [
                        FilteringTextInputFormatter.deny(RegExp("[0-9]")),
                      ],
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
                      controller: cubit.tradeNameController,
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DefaultFormField(
                      isNum: true,
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(10),
                      ],
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
                      controller:  cubit.idInstController,
                      inputType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    DefaultFormField(

                      obscureText: false,
                      astric: false,

                      labelString: 'Commercial Registration No',
                      inputFormatter: [
                        LengthLimitingTextInputFormatter(10),

                      ],
                      hintText: 'please enter your id name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalization.of(context)
                              .translate('Please enter your commercial registration No');
                        }
                        else if(value.length>10){
                          return AppLocalization.of(context).translate('Please enter 10 numbers');
                        }
                        return null;
                      },
                      controller: cubit.tradeNumberController,
                      inputType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppLocalization.of(context)
                          .translate('Cities you want to buy from')!,
                      style: const TextStyle(
                          fontFamily: "GE",
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    MultiSelectedItem(
                      selectedOptions: cubit.insSelectedOptions,
                      unSelectedOptions: cubit.insUnSelectedOptions,
                      selectedOptionsIds: cubit.insSelectedOptionsIds,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppLocalization.of(context).translate('Attach work permit')!,
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'GE',
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    BlocConsumer<AccountVerificationCubit,AccountVerificationStates>(
                      listener: (context,state){},
                      builder: (context,state){
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              elevation: 4,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              context: context,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        child: Text(
                                          AppLocalization.of(context)
                                              .translate('Camera')!,
                                          style: Styles.getBoldMainTextStyle(
                                              color: Colors.black,
                                              fontSize: FontSize.s18),
                                        ),
                                        onPressed: () {
                                          cubit.checkPermissionOpenCamera(2);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        child: Text(
                                          AppLocalization.of(context)
                                              .translate('Gallery')!,
                                          style: Styles.getBoldMainTextStyle(
                                              color: Colors.black,
                                              fontSize: FontSize.s18),
                                        ),
                                        onPressed: () {
                                          cubit.checkPermissionOpenPhoto(2);
                                          Navigator.pop(context);
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
                                        .workPremitInst ==
                                        null
                                        ? const AssetImage(
                                      'images/id.png',
                                    )
                                        : Image.file(
                                        AccountVerificationCubit.get(context)
                                            .workPremitInst!
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
                        );
                      },

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
                            if(cubit.workPremitInst==null){
                              return AppLocalization.of(context).translate('Please pick image');
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppLocalization.of(context)
                          .translate('Attach a copy of register')!,
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'GE',
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    BlocConsumer<AccountVerificationCubit,AccountVerificationStates>(
                      listener: (context,state){},
                      builder: (context,state){
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              elevation: 4,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                              context: context,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        child: Text(
                                          AppLocalization.of(context)
                                              .translate('Camera')!,
                                          style: Styles.getBoldMainTextStyle(
                                              color: Colors.black,
                                              fontSize: FontSize.s18),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          cubit.checkPermissionOpenCamera(3);

                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        child: Text(
                                          AppLocalization.of(context)
                                              .translate('Gallery')!,
                                          style: Styles.getBoldMainTextStyle(
                                              color: Colors.black,
                                              fontSize: FontSize.s18),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          cubit.checkPermissionOpenPhoto(3);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child:Stack(
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
                                        .logImage ==
                                        null
                                        ? const AssetImage(
                                      'images/id.png',
                                    )
                                        : Image.file(
                                        AccountVerificationCubit.get(context)
                                            .logImage!
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
                        );
                      },

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 30,
                        width: double.infinity,
                        child: TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(

                              border: InputBorder.none
                          ),
                          validator: (value){
                            if(cubit.logImage==null){
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
                          if(cubit.insSelectedOptionsIds.isEmpty){
                            for(var element in cubit.insUnSelectedOptions){
                              cubit.insSelectedOptionsIds.add(element.id!);
                            }
                          }
                          if(insKey.currentState!.validate()){
                            cubit.postAccountVerification(
                              personalId: cubit.idInstController.text,
                              name: cubit.tradeNameController.text,
                              type: '2',
                              workingLicenceImage: cubit.workPremitInst!,
                              city: cubit.insSelectedOptionsIds,
                              commericalLicenceImage: cubit.logImage,
                              commericalNumber: cubit.tradeNumberController.text,
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
