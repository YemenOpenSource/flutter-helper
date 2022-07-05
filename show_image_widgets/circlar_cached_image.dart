import 'package:lab_app/utils/constant/app_images.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CircularCachedImage extends StatelessWidget {
  final String? imageUrl;
  final double? radius;
  final double? borderWidth;
  final bool isUserPlaceHolder;
  final Color? borderColor;

  const CircularCachedImage({
    Key? key,
    required this.imageUrl,
    this.radius,
    this.isUserPlaceHolder = false,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProfileAvatar(
      imageUrl ?? '',
      child: imageUrl?.isEmpty ?? true ? buildImage() : null,
      radius: radius ?? 25.0.r,
      cacheImage: true,
      animateFromOldImageOnUrlChange: true,
      imageFit: BoxFit.cover,
      borderWidth: borderWidth ?? 1.0,
      borderColor: borderColor ?? Get.theme.primaryColor,
      placeHolder: (context, url) => buildImage(),
      errorWidget: (context, error, stackTrace) => buildImage(),
    );
  }

  Image buildImage() {
    return Image.asset(
      isUserPlaceHolder ? AppImages.userProfilePlaceHolderPng : AppImages.logo,
     // color: Get.theme.primaryColor,
     // colorBlendMode: BlendMode.color,
    );
  }
}
