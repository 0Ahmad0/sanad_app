import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/color_manager.dart';

class CircleProfilePictureWidget extends StatelessWidget {
  const CircleProfilePictureWidget({
    super.key,
    this.radius = 60.0,
    required this.path,
  });

  final double radius;
  final String path;

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
        child: Image.network(
          path,
          width: radius.sp,
          height: radius.sp,
        ),
      ),
    );
  }
}
