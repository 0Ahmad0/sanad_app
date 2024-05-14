import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/color_manager.dart';
import '../core/utils/values_manager.dart';

class ContainerAuthWidget extends StatelessWidget {
  const ContainerAuthWidget({
    super.key, this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(AppPadding.p8),
      margin: const EdgeInsets.all(AppMargin.m8),
      decoration: BoxDecoration(
          color: ColorManager.containerAuthColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorManager.secondaryColor,
          ),
          boxShadow: [
            BoxShadow(
                color: ColorManager.blackColor.withOpacity(.21),
                blurRadius: 4,
                offset: const Offset(2, 4)
            )
          ]
      ),
      child: child,
    );
  }
}
