import 'package:flutter/material.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class UnitDetailsItem extends StatelessWidget {
 String icon;
  String? title;
  String? value;
  double? height;
   UnitDetailsItem({
    required this.icon,
     required this.title,
     required this.value,
});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

     children: [
       Image(image: AssetImage(icon),height: 15,width: 15,),
       const SizedBox(width: 8,),
       Text(

         AppLocalization.of(context).translate(title!)!,

         style: TextStyle(
           fontFamily: 'GE',

           fontSize: 14,
           fontWeight: FontWeight.w400,
           color: Colors.grey.shade500,
         ),

       ),

       Text(
         ':',
         style: TextStyle(
           fontFamily: 'GE',
           fontSize: 18,
           fontWeight: FontWeight.w400,
           color: Colors.grey.shade500,
         ),

       ),
       const SizedBox(width: 8,),
       Expanded(
         child: Padding(
           padding: const EdgeInsets.only(top:6),
           child: Text(

             value!,

             maxLines: 1,
             overflow: TextOverflow.ellipsis,
             style: const TextStyle(
               fontFamily: 'Gill',
               fontSize: 14,
               fontWeight: FontWeight.w400,
               color: Colors.black,
             ),

           ),
         ),
       ),


     ],
    );
  }
}
