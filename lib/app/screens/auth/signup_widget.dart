import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad_app/app/core/helper/sizer_media_query.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/widgets/textfield_app.dart';

import '../../widgets/container_auth_widget.dart';
import 'widgets/divider_auth_widgets.dart';
class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerAuthWidget(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Spacer(),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: AppString.userName,
                style: StylesManager.textNormalStyle(
                    color: ColorManager.primaryColor, size: 16.sp),
              ),
              TextSpan(
                text: '*',
                style: StylesManager.textNormalStyle(
                    color: ColorManager.errorColor, size: 18.sp),
              ),
            ])),
            const DividerAuthWidget(),
            const SizedBox(height: AppSize.s10,),
            TextFiledApp(
              hintText: AppString.fullName,
            ),
            // const SizedBox(height: AppSize.s20,),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: AppString.passWord,
                style: StylesManager.textNormalStyle(
                    color: ColorManager.primaryColor, size: 16.sp),
              ),
              TextSpan(
                text: '*',
                style: StylesManager.textNormalStyle(
                    color: ColorManager.errorColor, size: 18.sp),
              ),
            ])),
            const DividerAuthWidget(),
            const SizedBox(height: AppSize.s10,),
            TextFiledApp(
              hintText: AppString.email,
            ),
            // const SizedBox(height: AppSize.s20,),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: AppString.passWord,
                style: StylesManager.textNormalStyle(
                    color: ColorManager.primaryColor, size: 16.sp),
              ),
              TextSpan(
                text: '*',
                style: StylesManager.textNormalStyle(
                    color: ColorManager.errorColor, size: 18.sp),
              ),
            ])),
            const DividerAuthWidget(),
            const SizedBox(height: AppSize.s10,),
            TextFiledApp(
              hintText: AppString.phone,
              keyboardType: TextInputType.phone,
            ),
            // const SizedBox(height: AppSize.s20,),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: AppString.passWord,
                style: StylesManager.textNormalStyle(
                    color: ColorManager.primaryColor, size: 16.sp),
              ),
              TextSpan(
                text: '*',
                style: StylesManager.textNormalStyle(
                    color: ColorManager.errorColor, size: 18.sp),
              ),
            ])),
            const DividerAuthWidget(),
            const SizedBox(height: AppSize.s10,),
            TextFiledApp(
              hintText: '●●●●●●●●',
            ),


          ],
        ),
      ),
    );
  }
}

