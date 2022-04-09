
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kayish/widgets/circular_prograss_indicator.dart';

class CustomImageNetwork extends StatelessWidget {
  final String image;

  final BoxFit fit;
  final BoxFit errorFit;
  final Color errorBackground;
  final double errorImageSize;
  final double loadingSize;
  final EdgeInsets errorPadding;

  const CustomImageNetwork({
    Key? key,
    required this.image,
    required this.fit,
    required this.errorBackground,
    required this.errorFit,

    required this.errorImageSize,
    required this.errorPadding,
    required this.loadingSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Image.network(
    //   image.toString(),
    //   fit: fit,
    //   alignment: Alignment.center,
    //   loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
    //     if (loadingProgress == null) return child;
    //     // return Center(
    //     //   child: CircularProgressIndicator(
    //     //     value: loadingProgress.expectedTotalBytes != null ?
    //     //     loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
    //     //     color: loadingColor,
    //     //     backgroundColor: loadingColor.withOpacity(0.2),
    //     //   ),
    //     // );
    //     return const SkeletonAvatar(
    //       style: SkeletonAvatarStyle(
    //       ),
    //     );
    //   },
    //
    //   errorBuilder: (context, error, stackTrace) {
    //     return Container(
    //       color: errorBackground,
    //       margin: errorPadding,
    //       child: Center(
    //         child: Image.asset(
    //           'assets/images/$errorImage.jpg',
    //           width: errorImageSize,
    //           height: errorImageSize,
    //           fit: errorFit,
    //         ),
    //       ),
    //     );
    //   },
    // );
    return CachedNetworkImage(
      fit: fit,
      alignment: Alignment.center,
      imageUrl: image.toString(),
      placeholder:(context, error,) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyCircularPrograssIndicator(),
          ],
        );
      },
      errorWidget: (context, error, stackTrace) {
        return Container(
          color: errorBackground,
          margin: errorPadding,
          child: Center(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'images/errorImage.jpg',
                width: errorImageSize,
                height: errorImageSize,
                fit: errorFit,
              ),
            ),
          ),
        );
      },
    );

  }
}
