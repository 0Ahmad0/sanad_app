import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/controller/admin_controller.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/button_app_widget.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/textfield_app.dart';
import '../widgets/elderly_widget.dart';

class AddLessonAdminScreen extends StatelessWidget {
  const AddLessonAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultScaffoldWidget(
        child: FadeIn(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSize.s60,
                  ),
                  Text(
                    AppString.addLesson,
                    style: StylesManager.textBoldStyle(
                      color: ColorManager.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                  const DividerAuthWidget(),

                  ContainerAuthWidget(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSize.s10,),
                        Text(AppString.lessonName,style: StylesManager.textNormalStyle(
                          color: ColorManager.primaryColor,
                          size: 14.sp
                        ),),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          suffixIcon: false,
                        ),
                        const SizedBox(height: AppSize.s20,),
                        Text(AppString.lessonDescription,style: StylesManager.textNormalStyle(
                            color: ColorManager.primaryColor,
                            size: 14.sp
                        )),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          suffixIcon: false,
                          minLine: 3,
                          maxLine: 8,
                        ),
                        const SizedBox(height: AppSize.s10,),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  ContainerAuthWidget(
                    child: GetBuilder<AdminController>(
                      init: AdminController(),
                      builder: (adminController) {
                        return Column(
                          children: [
                            const SizedBox(height: AppSize.s10,),
                            ListTile(
                              onTap: (){},
                              leading: Image.asset(AssetsManager.adminImageIcon),
                              title: Text(AppString.uploadImageAdmin,style: StylesManager.textNormalStyle(
                                  size: 14.sp,
                                  color: ColorManager.secondaryColor
                              ),),
                            ),
                            ListTile(
                              onTap: (){
                                adminController.pickAudio();
                              },
                              leading: Image.asset(AssetsManager.adminSoundIcon),
                              title: Text(AppString.uploadSoundAdmin,style: StylesManager.textNormalStyle(
                                  size: 14.sp,
                                  color: ColorManager.secondaryColor
                              ),),
                            ),
                            ListTile(
                              onTap: (){
                                adminController.pickVideo();
                              },
                              leading: Image.asset(AssetsManager.adminVideoIcon),
                              title: Text(AppString.uploadVideoAdmin,style: StylesManager.textNormalStyle(
                                size: 14.sp,
                                color: ColorManager.secondaryColor
                              ),),
                            ),
                            const SizedBox(height: AppSize.s10,),

                          ],
                        );
                      }
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                    child: ButtonAppWidget(onPressed: (){}, text: AppString.save),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
