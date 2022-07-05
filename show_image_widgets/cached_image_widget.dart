
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lab_app/utils/constant/app_images.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RectangularCachedImage extends StatelessWidget {
  const RectangularCachedImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.fit,
    this.width,
    this.placeHolder,
    this.borderRadius,
    this.color
  }) : super(key: key);

  final String? imageUrl;
  final double? height;
  final BoxFit? fit;
  final double? width;
  final double? borderRadius;
  final String? placeHolder;
  final Color?  color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child:
      (imageUrl?.isEmpty??true)
          ?     placeHolder != null
          ? Image.asset(
        placeHolder!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      )
          : SizedBox(
        height: height,
        width: width,
        child: Card(
          elevation: 0,
          color: Get.theme.scaffoldBackgroundColor,
          child: Opacity(
            opacity: 0.5,
            child: Icon(
              Icons.image,
              size: 80,
              color: Get.theme.hintColor,
            ),
          ),
        ),
      )
          :imageUrl!.split(".").last=='svg'?
      SvgPicture.network(
        imageUrl!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color:color,
      ):

      CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          height: height,
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
              )),
        ),
        imageUrl:imageUrl!,
        fit: fit ?? BoxFit.cover,
        errorWidget: (context, url, error) => Icon(
          FontAwesomeIcons.image,
          size: 60,
          color: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
        placeholder: (context, url) => Image.asset(
          placeHolder ?? AppImages.testPlaceHolder,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
        ),
      ),
    );
  }
}
