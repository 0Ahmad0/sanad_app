import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/core/helper/sizer_media_query.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/assets_manager.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/widgets/default_scaffold.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getHeight(context) / 9,),
              Text(
                AppString.welcomeAdminTitle,
                style: StylesManager.textBoldStyle(
                    size: 22.sp, color: ColorManager.primaryColor),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              Text(
                AppString.aboutSanadApp,
                style: StylesManager.textNormalStyle(
                    size: 14.sp, color: ColorManager.primaryColor),
              ),
              const SizedBox(
                height: AppSize.s30,
              ),
              Text(
                AppString.welcomeAdminSubTitle,
                style: StylesManager.textNormalStyle(
                    size: 14.sp, color: ColorManager.primaryColor),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: getHeight(context) / 3.5,
          child: Image.asset(
            AssetsManager.logoAdminIMG,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
