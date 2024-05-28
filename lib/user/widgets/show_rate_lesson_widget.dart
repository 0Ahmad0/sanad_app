import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/screens/auth/widgets/divider_auth_widgets.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';

import 'show_media_lesson_widget.dart';

class ShowRateLessonWidget extends StatelessWidget {
  const ShowRateLessonWidget({
    super.key,
    required this.lessonName,
  });

  final String lessonName;

  @override
  Widget build(BuildContext context) {
    return ContainerAuthWidget(
      child: ListTile(
        trailing: TextButton.icon(
            onPressed: () {
              Get.dialog(RateDialogWidget(
                degreeRate: 5,
              ));
            },
            icon: Image.asset(
              AssetsManager.showEyeIcon,
              width: 20.sp,
              height: 20.sp,
              fit: BoxFit.cover,
            ),
            label: Text(AppString.myRateLesson)),
        contentPadding: EdgeInsets.zero,
        title: Text(
          lessonName,
          style: StylesManager.textBoldStyle(
              color: ColorManager.primaryColor, size: 14.sp),
        ),
      ),
    );
  }
}

class RateDialogWidget extends StatelessWidget {
  const RateDialogWidget({super.key, required this.degreeRate});

  final int degreeRate;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BounceInDown(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppMargin.m40),
              child: ContainerAuthWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Text(
                      AppString.rateDegree,
                      style: StylesManager.textBoldStyle(
                          size: 16.sp, color: ColorManager.primaryColor),
                    ),
                    DividerAuthWidget(),
                    Center(
                      child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: '10',
                                style: StylesManager.textNormalStyle(
                                    size: 45.sp,
                                    color: ColorManager.primaryColor)),
                            TextSpan(
                                text: ' / ',
                                style: StylesManager.textNormalStyle(
                                    size: 50.sp,
                                    color: ColorManager.primaryColor)),
                            TextSpan(
                              text: '${degreeRate}',
                              style: StylesManager.textBoldStyle(
                                size: 50.sp,
                                color: degreeRate == 5
                                    ? Colors.orange
                                    : degreeRate > 5
                                        ? ColorManager.successColor
                                        : ColorManager.errorColor,
                              ),
                            ),
                          ])),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    TextButton(
                        onPressed: () => Get.back(), child: Text(AppString.ok))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
