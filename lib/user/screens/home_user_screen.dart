import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/controller/user_controller.dart';
import 'package:sanad_app/app/core/helper/sizer_media_query.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/screens/auth/widgets/divider_auth_widgets.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

class HomeUserScreen extends StatelessWidget {
  const HomeUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return DefaultScaffoldWidget(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppString.homeUser,
                  style: StylesManager.textBoldStyle(
                      color: ColorManager.primaryColor, size: 16.sp),
                ),
                DividerAuthWidget(),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Column(
                  children: List.generate(
                      controller.homeButton.length,
                      (index) => ContainerAuthWidget(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: AppSize.s20,
                                ),
                                Image.asset(
                                  controller.homeButton[index].image,
                                  width: getWidth(context) / 6,
                                  height: getWidth(context) / 6,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: AppSize.s40,
                                ),
                                Text(
                                  controller.homeButton[index].lable,
                                  style: StylesManager.textBoldStyle(
                                      color: ColorManager.primaryColor),
                                )
                              ],
                            ),
                          )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeUserModel {
  final String lable;
  final String image;
  final VoidCallback navigate;

  HomeUserModel({
    required this.lable,
    required this.image,
    required this.navigate,
  });
}
