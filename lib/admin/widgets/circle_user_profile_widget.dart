import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../user/widgets/picture/cach_picture_widget.dart';
import '../../../../user/widgets/picture/profile_picture_widget.dart';
import '../../app/core/utils/color_manager.dart';

class CircleUserProfilePictureWidget extends StatelessWidget{
  const CircleUserProfilePictureWidget({
    super.key,
    this.radius = 60.0,
    required this.url,
    required this.name,
  });

  final double radius;
  final String? url;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.primaryColor,
            width: 1.5,
          ),
          shape: BoxShape.circle),
      child: Container(
        width: radius.sp,
        height: radius.sp,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child:

  CacheNetworkImage(
          photoUrl:   // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
          '${ url??''}',
          width: radius.sp,
          height: radius.sp,
          boxFit: BoxFit.cover,
          waitWidget: WidgetProfilePicture(
            name:name??'',
            radius: radius.sp,
            backgroundColor: ColorManager.secondaryColor,
            textColor: ColorManager.primaryColor,
          ),
          errorWidget: WidgetProfilePicture(
            name: name??'',
            radius: radius.sp,

            backgroundColor: ColorManager.secondaryColor,
            textColor: ColorManager.primaryColor,
          ),
        ),
      ),
    );
  }
}
