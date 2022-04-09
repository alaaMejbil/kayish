 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/localization/localizationSetup/app_localization.dart';

class  DropDownMenuItem<H> extends StatefulWidget {
  String? title;
  H? dropValue;
   List<H> dropList=[];
  ValueChanged<H?>? onChange;
  String? selectedName;
  int? selectedId;


DropDownMenuItem({
  required this.title,
  required this.dropValue,
  required this. dropList,
  required this.onChange,
  required this.selectedName,
  required this.selectedId
});

  @override
  _DropDownMenuItemState<H> createState() => _DropDownMenuItemState<H>();
}

class _DropDownMenuItemState<H> extends State<DropDownMenuItem> {


   @override
   Widget build(BuildContext context) {
     return  Padding(
       padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(
             AppLocalization.of(context).translate(widget.title!)!,
             style: const TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.w500,
               fontSize: 16,
             ),
           ),
           Container(
             height: 28,
             child: DropdownButton<H>(
               isExpanded: true,
               icon: Icon(
                 Icons.keyboard_arrow_down_sharp,
                 color: Colors.grey[500],
                 size: 25,
               ),
               underline: SizedBox(),
               value: widget.dropValue,
               style: TextStyle(
                 color: Colors.grey[500],
                 fontSize: 16,
               ),
               onChanged: widget.onChange,
               items: widget.dropList.map(
                     (dynamic selectedItem) {
                   return DropdownMenuItem<H>(
                     child: Text(widget.selectedName!),
                     value: selectedItem,



                   );
                 },
               ).toList(),
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
