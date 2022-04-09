import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayish/shared/component/color_manager.dart';
import 'package:kayish/shared/component/styles.dart';

class NotificationItem extends StatelessWidget {
String? image;
String? title;
String? date;
String? time;

NotificationItem({
  required this.image,
  required this.title,
  required this.date,
  required this.time,
});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
         crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: ColorManager.primary,

                child:Image(
                  image: AssetImage('images/notification_image.png'),
                ) ,

              ),
            ),
            Expanded(
              flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                        fontFamily: 'GE',
                        fontSize: 14,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w700,
                      ),

                    ),
                  ],
                )
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date!,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontFamily: 'Gill',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Text(
                    time!,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Gill',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
