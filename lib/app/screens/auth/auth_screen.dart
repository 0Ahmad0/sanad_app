
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sanad_app/app/controller/auth_controller.dart';
import 'package:sanad_app/app/core/helper/sizer_media_query.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/screens/auth/login_widget.dart';
import 'package:sanad_app/app/screens/auth/signup_widget.dart';
import 'package:sanad_app/app/widgets/button_app_widget.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: const CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: GetBuilder<AuthController>(
              init: AuthController(),
              builder: (_) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.welcomeAgain,
                        style: StylesManager.textBoldStyle(
                            size: 20.sp, color: ColorManager.primaryColor),
                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(AppPadding.p4),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Row(
                          children: List.generate(
                              controller.tabsList.length,
                              (index) => Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.navigateToPage(index);
                                      },
                                      child: AnimatedContainer(
                                        alignment: Alignment.center,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        padding: EdgeInsets.all(AppPadding.p4),
                                        margin: EdgeInsets.all(AppMargin.m8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color:
                                              controller.currentIndex == index
                                                  ? ColorManager.tabSelectColor
                                                  : ColorManager.primaryColor,
                                        ),
                                        child: Text(
                                          controller.tabsList[index],
                                          style: StylesManager.textBoldStyle(
                                            size: 16.sp,
                                            color:
                                                controller.currentIndex == index
                                                    ? ColorManager.primaryColor
                                                    : ColorManager.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        height: controller.currentIndex == 0?getHeight(context) / 2:getHeight(context) / 1.8,
                        child: Form(
                          key: controller.formKey,
                          child: PageView(
                            onPageChanged: (index) {
                              controller.navigateToPage(index);
                            },
                            controller: controller.pageController,
                            children: [
                              LoginWidget(),
                              SignUpWidget(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p40),
                        child: ButtonAppWidget(
                            onPressed: () {
                              if(controller.formKey.currentState!.validate()){

                              }
                            }, text: AppString.registration),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
