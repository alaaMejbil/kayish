import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnableButton extends StatefulWidget {
 CircleAvatar? child;
 Color? color;
 BorderRadius? borderRadius;
 BoxShape? boxShape;
 Border? border;
 bool? disable;
 GestureTapCallback? onTap;

 EnableButton({
   required this.child,

   this.disable=false,
   this.onTap
});

  @override
  State<EnableButton> createState() => _EnableButtonState();
}

class _EnableButtonState extends State<EnableButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
            onTap: widget.disable==false?
              widget.onTap: null
           ,
        child: widget.child
    );
  }
}
