import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/profile%20cubit/cubit.dart';
import 'package:kayish/blocs/profile%20cubit/states.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';
import 'package:kayish/widgets/profile_label.dart';

class ProfileScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ProfileCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.lightGrey,
          appBar:  AppBar(
            title: Text(AppLocalization.of(context).translate('Profile')!,style: appBarTitle,),
            centerTitle: true,
            elevation: 0.0,
            leading:IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
              },
            ),

            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            ),

          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 32,start: 32,top: 16),
                child: Column(

                  children: [
                    const CircleAvatar(

                      backgroundImage: AssetImage('images/profile.png',),

                      radius: 35,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16,),
                    Text(
                     cubit.profileModel!.data!.profile!.name!,
                      style:bodyTextStyle,
                    ),
                    const SizedBox(height: 8,),
                    Text(

                      cubit.profileModel!.data!.profile!.phone!,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          fontFamily: 'Gill',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade700

                      ),

                    ),
                    const SizedBox(height: 30,),
                    ProfileLabel(
                      title: 'Full name',
                      value:  cubit.profileModel!.data!.profile!.name!,
                      valueTextStyle:  TextStyle(
                          fontFamily: 'GE',
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Colors.grey.shade500
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Divider(
                      color: Colors.grey.shade500,
                      height: 2,
                    ),
                    const SizedBox(height: 8,),
                    ProfileLabel(
                      title: 'Mobile number',
                      value:  cubit.profileModel!.data!.profile!.phone!,
                      valueTextStyle:  TextStyle(
                          fontFamily: 'Gill',
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Colors.grey.shade500
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Divider(
                      color: Colors.grey.shade500,
                      height: 2,
                    ),
                    const SizedBox(height: 8,),
                    ProfileLabel(
                      title: 'Age',
                      value:  cubit.profileModel!.data!.profile!.age,
                      valueTextStyle:  TextStyle(
                          fontFamily: 'Gill',
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Colors.grey.shade500
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Divider(
                      color: Colors.grey.shade500,
                      height: 2,
                    ),
                    const SizedBox(height: 8,),
                    ProfileLabel(
                      title: 'Email address',
                      value:  cubit.profileModel!.data!.profile!.email,
                      valueTextStyle:  TextStyle(
                          fontFamily: 'Gill',
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          color: Colors.grey.shade500
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Divider(
                      color: Colors.grey.shade500,
                      height: 2,
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
