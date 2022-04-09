import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/blocs/Account%20verification%20cubit/cubit.dart';
import 'package:kayish/models/city_model.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';


class MultiSelectedItem extends StatefulWidget {
List<City>? selectedOptions;
List<City>? unSelectedOptions;
List<int>? selectedOptionsIds;



 MultiSelectedItem({
  required this.selectedOptions,
   required this.unSelectedOptions,
   required this.selectedOptionsIds


});


  @override
  State<MultiSelectedItem> createState() => _MultiSelectedItemState();




}

class _MultiSelectedItemState extends State<MultiSelectedItem> {





  void addOption({ required City city}) {
    widget.selectedOptions!.add(city);
    widget.unSelectedOptions!.remove(city);
    widget.selectedOptionsIds!.add(city.id!);

    setState(() {

    });


  }
  void removeSelectedOption({required City city }) {
    widget.unSelectedOptions!.add(city);
    widget.selectedOptions!.remove(city);
    widget.selectedOptionsIds!.remove(city.id!);
    setState(() {

    });


  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500,width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton<City>(
            hint:  Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Text(AppLocalization.of(context).translate('Select')!),
            ),
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.grey[500],
            ),
            onChanged: (value) {},
            underline: SizedBox(),
            value: null,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
            items: widget.unSelectedOptions!.map(
                  (City selectedItem) {
                return DropdownMenuItem(
                  child: Text(selectedItem.name!),
                  value: selectedItem,
                  onTap: () {

                   addOption(
                      city: selectedItem,
                    );


                  },
                );
              },
            ).toList(),
          ),
        ),
        Container(
          height: 1.3,
          color: Colors.grey[300],
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          child: Container(

            child: Wrap(
               children:[
                 ...List.generate(widget.selectedOptions!.length, (index) =>
                     Padding(
                       padding: const EdgeInsets.all(8),
                       child: FittedBox(

                         child: Stack(
                           fit: StackFit.passthrough,
                           children: [
                             Container(

                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),

                                 color: ColorManager.primary,
                               ),
                               child: Padding(
                                 padding: const EdgeInsetsDirectional.only(
                                     end: 14.0, start: 14, top: 12, bottom: 12),
                                 child: Text(widget.selectedOptions![index].name!,textAlign: TextAlign.center,),
                               ),
                             ),
                             Align(
                               alignment: AlignmentDirectional.topStart,
                               child: InkWell(
                                 onTap: () {

                                   removeSelectedOption(city: widget.selectedOptions![index]);
                                   setState(() {

                                   });






                                 },
                                 child: const Padding(
                                   padding: EdgeInsetsDirectional.only(top: 5,start: 5),
                                   child: Icon(
                                     Icons.close,
                                     color: Colors.white,
                                     size: 15,
                                   ),
                                 ),
                               ),
                             )
                           ],
                         ),
                       ),
                     ))
               ]
                 // widget.selectedOptions!


            ),
          ),
        ),
      ],
    );
  }
}
