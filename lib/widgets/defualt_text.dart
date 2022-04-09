import 'package:flutter/cupertino.dart';

class DefaultText extends StatelessWidget{
  String? myText;
  TextStyle? style;
  int? maxLines;
  TextAlign? alignment;
  TextOverflow? overflow;
  DefaultText({
    this.myText,
    this.style,
    this.alignment,
    this.maxLines,
    this.overflow
});


  @override
  Widget build(BuildContext context) {
    return Text(
      '$myText',
      style: style,
      textAlign: alignment,
      maxLines: maxLines,
      overflow: overflow,


    );
  }

}