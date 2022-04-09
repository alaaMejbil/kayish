import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kayish/blocs/app%20cubit/app_cubit.dart';
import 'package:kayish/blocs/app%20cubit/app_states.dart';
import 'package:kayish/blocs/home%20cubit/cubit.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/date_functions.dart';
import 'package:kayish/shared/component/styles.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';
import 'package:kayish/shared/network/local/cashe_helper.dart';

class LangSettings extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder:  (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.lightGrey,
          appBar: AppBar(
            title: Text(AppLocalization.of(context).translate('Language Settings')!,style: appBarTitle,),
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
          body: Container(
            color: Colors.white,
            child: Column(

                mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                   minLeadingWidth: 0,
                     horizontalTitleGap: 5,
                    onTap: (){

                     print( CasheHelper.getData(key: 'isArabic'));
                      AppCubit.get(context).changeLang(true);
                     HomeCubit.get(context).getHomeData(realStateTypeId: 0,districtId: 0,regionId: 0,cityId: 0);
                    },
                    leading:  const Text('العربية') ,
                    title: Row(

                      children: const [
                        Image(image: AssetImage('icons/saudi.png'),width: 20,height: 20,),
                      ],
                    ),
                    trailing:  Visibility(
                      visible: CasheHelper.getData(key: 'isArabic')==true||CasheHelper.getData(key: 'isArabic')==null,
                      child:const  Icon(
                        Icons.check,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListTile(
                    horizontalTitleGap: 4,
                    contentPadding:const EdgeInsetsDirectional.only(start: 6,end: 6),
                    minLeadingWidth: 0,
                    onTap: (){

                      print( CasheHelper.getData(key: 'isArabic'));
                      AppCubit.get(context).changeLang(false);
                      HomeCubit.get(context).getHomeData(realStateTypeId: 0,districtId: 0,regionId: 0,cityId: 0);
                    },
                    leading:  const Text('English') ,
                    title: Row(
                      children: const [
                        Image(image: AssetImage('icons/us.png'),width: 20,height: 20,),
                      ],
                    ),
                    trailing:  Visibility(
                      visible: CasheHelper.getData(key: 'isArabic')==false,
                      child:const  Icon(
                        Icons.check,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),

               ],
            ),
          ),
        );
      },

    );
  }
}
