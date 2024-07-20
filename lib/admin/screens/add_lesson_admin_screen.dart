import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sanad_app/app/core/route/app_route.dart';

import '../../app/controller/admin_controller.dart';
import '../../app/controller/lesson_controller.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/assets_manager.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/button_app_widget.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/default_scaffold.dart';
import '../../app/widgets/textfield_app.dart';

class AddLessonAdminScreen extends StatelessWidget {
  AddLessonAdminScreen({super.key});

  late LessonController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(LessonController());
    Get.put(AdminController()).refreshPicker();

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
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Text(
                          AppString.lessonName,
                          style: StylesManager.textNormalStyle(
                              color: ColorManager.primaryColor, size: 14.sp),
                        ),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          controller: controller.nameController,
                          suffixIcon: false,
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                        Text(AppString.lessonDescription,
                            style: StylesManager.textNormalStyle(
                                color: ColorManager.primaryColor, size: 14.sp)),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          controller: controller.descriptionController,
                          suffixIcon: false,
                          minLine: 3,
                          maxLine: 8,
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
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
                              const SizedBox(
                                height: AppSize.s10,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                trailing: controller.lesson?.imagesPath.isEmpty??true
                                    ? SizedBox.shrink()
                                    : IconButton(
                                        onPressed: () {
                                          Get.toNamed(
                                              AppRoute.showMediaLessonsRoute);
                                        },
                                        icon: Icon(Icons.arrow_forward_ios)),
                                onTap: () {
                                  adminController.pickImages();
                                },
                                leading:
                                    Image.asset(AssetsManager.adminImageIcon),
                                subtitle: adminController.images.isEmpty &&
                                        (controller
                                                .lesson?.imagesPath.isEmpty ??
                                            true)
                                    ? null
                                    : Text.rich(
                                        maxLines: 2,
                                        TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  '${adminController.images.isNotEmpty ? adminController.images.length : controller.lesson?.imagesPath.length} - ',
                                              style:
                                                  StylesManager.textNormalStyle(
                                                      color: ColorManager
                                                          .secondaryColor)),
                                          TextSpan(
                                            text: AppString.image,
                                          ),
                                        ])),
                                title: Text(
                                  AppString.uploadImageAdmin,
                                  style: StylesManager.textNormalStyle(
                                      size: 14.sp,
                                      color: ColorManager.secondaryColor),
                                ),
                              ),
                              ListTile(
                                trailing: controller.lesson?.filePath == null
                                    ? SizedBox.shrink()
                                    : IconButton(
                                        onPressed: () {
                                          Get.toNamed(
                                              AppRoute.showMediaLessonsRoute);
                                        },
                                        icon: Icon(Icons.arrow_forward_ios)),
                                contentPadding: EdgeInsets.zero,
                                onTap: () {
                                  adminController.pickAudio();
                                },
                                leading:
                                    Image.asset(AssetsManager.adminSoundIcon),
                                subtitle: adminController.audioFile == null &&
                                        (controller.lesson?.filePath == null)
                                    ? null
                                    : Text(
                                        maxLines: 2,
                                        '${basename(adminController.audioFile?.path ??controller.lesson?.fileName?? controller.lesson?.filePath ?? '')}'),
                                title: Text(
                                  AppString.uploadSoundAdmin,
                                  style: StylesManager.textNormalStyle(
                                      size: 14.sp,
                                      color: ColorManager.secondaryColor),
                                ),
                              ),
                              ListTile(
                                trailing: controller.lesson?.videoPath == null
                                    ? SizedBox.shrink()
                                    : IconButton(
                                        onPressed: () {
                                          Get.toNamed(
                                              AppRoute.showMediaLessonsRoute);
                                        },
                                        icon: Icon(Icons.arrow_forward_ios)),
                                contentPadding: EdgeInsets.zero,
                                onTap: () {
                                  adminController.pickVideo();
                                },
                                leading:
                                    Image.asset(AssetsManager.adminVideoIcon),
                                subtitle: adminController.videoFile == null &&
                                        (controller.lesson?.videoPath == null)
                                    ? null
                                    : Text(
                                        maxLines: 2,
                                        '${basename(adminController.videoFile?.path ?? controller.lesson?.videoName ??controller.lesson?.videoPath ?? '')}'),
                                title: Text(
                                  AppString.uploadVideoAdmin,
                                  style: StylesManager.textNormalStyle(
                                      size: 14.sp,
                                      color: ColorManager.secondaryColor),
                                ),
                              ),
                              const SizedBox(
                                height: AppSize.s10,
                              ),
                            ],
                          );
                        }),
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                    child: controller.lesson == null
                        ? ButtonAppWidget(
                            onPressed: () {
                              AdminController adminController =
                                  Get.put(AdminController());

                              controller.addLesson(context,
                                  videoFile: adminController.videoFile,
                                  audioFile: adminController.audioFile,
                                  images: adminController.images);
                            },
                            text: AppString.save)
                        : ButtonAppWidget(
                            onPressed: () {
                              AdminController adminController =
                                  Get.put(AdminController());
                              controller.updateLesson(context,
                                  videoFile: adminController.videoFile,
                                  audioFile: adminController.audioFile,
                                  images: adminController.images);
                            },
                            text: AppString.edit),
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
