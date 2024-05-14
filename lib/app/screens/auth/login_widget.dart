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

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerAuthWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: AppSize.s20,),
          Expanded(
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
                    hintText: AppString.userName,
                  ),
                  const SizedBox(height: AppSize.s20,),
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
                  TextButton(onPressed: (){}, child: Text(AppString.forgetPassword)),
                  // const Spacer(),
                  
                ],
              ),
            ),
          ),
          Text(AppString.thisMarkMeainingFiledIsRequired,style: StylesManager.textBoldStyle(
              color: ColorManager.errorColor,
              size: 10.sp
          ),)
        ],
      ),
    );
  }
}

