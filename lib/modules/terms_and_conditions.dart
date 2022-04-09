import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/policy%20cubit/cubit.dart';
import 'package:kayish/blocs/policy%20cubit/states.dart';
import 'package:kayish/modules/layout_screen.dart';
import 'package:kayish/modules/login_screen.dart';
import 'package:kayish/modules/verefication_code_screen.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/navigate_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/default_button.dart';

class TermsAndConditionsScreen extends StatefulWidget {

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsClassState();
}

class _TermsAndConditionsClassState extends State<TermsAndConditionsScreen> {
  bool checked=false;
  void changeChecked(value){
    checked=value;
    setState(() {

    });
  }
  ScrollController controller=ScrollController();

  @override
  Widget build(BuildContext context) {
    CasheHelper.putData(key: 'screen name', value: 'terms and conditions');
    return Scaffold(
      body: BlocConsumer<PolicyCubit,PolicyStates>(
        listener: (context,state){},
        builder: (context,state){
          return  Stack(
            alignment: Alignment.center,
            children: [
              Container(

                decoration:  BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  image: const DecorationImage(
                      image: AssetImage('images/termsImage.png'),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 140),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalization.of(context).translate('Terms and conditions')!,
                            style: appBarTitle,

                          ),
                          const SizedBox(height: 8,),
                          Divider(
                            height: 2,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(height: 12,),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalization.of(context).translate('Please read these terms carefully')!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'GE',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(

                            child: Scrollbar(
                              scrollbarOrientation: ScrollbarOrientation.right,
                              interactive: true,
                              controller: controller,
                              thickness: 3,
                              isAlwaysShown: true,

                              radius: Radius.circular(4),

                              child: Container(
                                margin: EdgeInsetsDirectional.only(start: 8,end: 8,top: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorManager.lightGrey,
                                ),

                                child: ListView(

                                  padding:EdgeInsets.only(top: 8) ,
                                  controller: controller,
                                  children:  [
                                    Text(
                                      PolicyCubit.get(context).policyModel!.data!.policy!,
                                      style:  const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black

                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                child: Checkbox(
                                  activeColor: Colors.green,

                                  value: checked,
                                  onChanged: (value){
                                    changeChecked(value);
                                  },
                                ),
                              ),

                              Text(
                                AppLocalization.of(context).translate('I agree to these terms and conditions')!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'GE',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),



                            ],
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: DefaultButton(
                              height: 45,
                              borderColor: checked==true?ColorManager.primary:ColorManager.primary.withOpacity(.4),

                              text: 'Sign Up',
                              textColor:checked==true? Colors.white:Colors.white.withOpacity(.8),
                              onPressed: checked==true?
                                  (){
                                navigateAndFinish(context: context, nextScreen: MobileVerification());
                                CasheHelper.putData(key: 'screen name', value: 'done');
                              }
                                  :null,

                              buttonColor: checked==true?ColorManager.primary:ColorManager.primary.withOpacity(.4),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },

      ),
    );
  }
}
