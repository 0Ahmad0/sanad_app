import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/controller/auth_controller.dart';
import 'package:sanad_app/app/core/helper/sizer_media_query.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/widgets/button_app_widget.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
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
              StatefulBuilder(
                  builder: (_, authSetState) => Container(
                        padding: const EdgeInsets.all(AppPadding.p10),
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
                                        padding: EdgeInsets.all(AppPadding.p10),
                                        margin: EdgeInsets.all(AppMargin.m8),
                                        decoration: BoxDecoration(
                                          color: index ==
                                                  controller.pageController
                                                      .initialPage
                                              ? ColorManager.tabSelectColor
                                              : ColorManager.primaryColor,
                                        ),
                                        child: Text(
                                          controller.tabsList[index],
                                          style: StylesManager.textBoldStyle(
                                            size: 16.sp,
                                            color: controller.pageController
                                                        .initialPage ==
                                                    index
                                                ? ColorManager.primaryColor
                                                : ColorManager.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      )),
              Expanded(
                child: PageView(
                  onPageChanged: (index){
                    controller.navigateToPage(index);
                  },
                  controller: controller.pageController,
                  children: [
                    Container(
                      color: Colors.teal,
                    ),
                    Container(
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              ButtonAppWidget(onPressed: () {}, text: AppString.registration)
            ],
          ),
        ),
      ),
    );
  }
}
