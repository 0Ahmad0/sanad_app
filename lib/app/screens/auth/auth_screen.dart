import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/helper/validator.dart';
import '../../../main.dart';
import '../../controller/auth_controller.dart';
import '../../core/helper/sizer_media_query.dart';
import '../../core/utils/app_string.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/styles_manager.dart';
import '../../core/utils/values_manager.dart';
import 'login_widget.dart';
import 'signup_widget.dart';
import '../../widgets/button_app_widget.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/default_scaffold.dart';

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
                      const SizedBox(
                        height: AppSize.s10,
                      ),
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
                                        padding: EdgeInsets.all(AppPadding.p6),
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
                        height: controller.currentIndex == 0
                            ? getHeight(context) / 2
                            : getHeight(context) / 1.7,
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
                            onPressed: () async {
                              // audio.dispose();
                              if (controller.formKey.currentState!.validate()) {
                                // Get.offAllNamed(AppRoute.navBarAdminRoute);
                                // Get.offAll(NavbarUserScreen());
                                controller.currentIndex == 0
                                    ? controller.login()
                                    : controller.signUp();
                              } else {
                                if (controller.passwordController.text.length >
                                    8) if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(
                                        controller.passwordController.text)) {
                                  if (!RegExp(r'[a-z]').hasMatch(
                                          controller.passwordController.text) ||
                                      !RegExp(r'[A-Z]').hasMatch(
                                          controller.passwordController.text)) {
                                    await audio.play(AssetSource(
                                        AssetsManager.passLetterSound));
                                    // return 'خطـأ';
                                  }

                                  if (!RegExp(r'[0-9]').hasMatch(
                                      controller.passwordController.text)) {
                                    await audio.play(AssetSource(
                                        AssetsManager.passNumberSound));

                                    // return 'خطـأ';
                                  }
                                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                      .hasMatch(
                                          controller.passwordController.text)) {
                                    await audio.play(AssetSource(
                                        AssetsManager.passSymbolSound));

                                    // return 'خطـأ';
                                  }
                                }
                              }
                            },
                            text: AppString.registration),
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
