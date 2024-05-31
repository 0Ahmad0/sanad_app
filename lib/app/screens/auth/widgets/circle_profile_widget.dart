import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/controller/profile_controller.dart';

import '../../../core/utils/color_manager.dart';

class CircleProfilePictureWidget extends GetView<ProfileController> {
  const CircleProfilePictureWidget({
    super.key,
    this.radius = 60.0,
    required this.path,
  });

  final double radius;
  final String? path;

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
        child:  controller.profileImage== null? Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS37JAC_YF1l4Nih5_FG15JI_EuFVRvVsveZKTGBNsmfqyeLGzTKMWY-prH8CGsLkxbb4&usqp=CAU',
          width: radius.sp,
          height: radius.sp,
          fit: BoxFit.cover,
        ):Image.file(
          File(path!),
          width: radius.sp,
          height: radius.sp,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
