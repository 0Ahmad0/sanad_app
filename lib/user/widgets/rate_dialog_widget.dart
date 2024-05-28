import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/container_auth_widget.dart';

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
