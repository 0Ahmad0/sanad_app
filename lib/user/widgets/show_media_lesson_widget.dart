import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';

class ShowMediaLessonWidget extends StatelessWidget {
  const ShowMediaLessonWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
     this.isActive=true,
  });

  final bool isActive;
  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextButton.icon(
        onPressed: onTap,
        icon: Image.asset(
          image,
          color: isActive?null:ColorManager.greyColor,
          width: 20.sp,
          height: 20.sp,
          fit: BoxFit.fill,
        ),
        label: Text(
          title,
          overflow: TextOverflow.clip,
          style: StylesManager.textBoldStyle(
            size: 8.sp,
              color: isActive? ColorManager.secondaryColor:ColorManager.greyColor,
          ),
        ),
      ),
    );
  }
}
