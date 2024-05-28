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

class DialogWidget extends StatelessWidget {
  const DialogWidget(
      {super.key,
      required this.text,
      required this.title,
       this.buttonOkText = 'نعم',
       this.buttonNoText = 'لا',
      required this.onPressed});

  final String text;
  final String title;
  final String buttonOkText;
  final String buttonNoText;
  final VoidCallback onPressed;

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
                      title,
                      style: StylesManager.textBoldStyle(
                          size: 16.sp, color: ColorManager.primaryColor),
                    ),
                    DividerAuthWidget(),
                    Center(
                      child: Text(
                        text,
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    TextButton(
                        onPressed: () => Get.back(), child: Text(buttonNoText)),
                    TextButton(onPressed: onPressed, child: Text(buttonOkText)),
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
