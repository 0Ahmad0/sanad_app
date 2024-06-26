import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../controller/profile_controller.dart';
import '../core/utils/app_string.dart';
import '../core/utils/assets_manager.dart';
import '../core/utils/color_manager.dart';
import '../core/utils/styles_manager.dart';
import '../core/utils/values_manager.dart';
import 'auth/widgets/divider_auth_widgets.dart';
import '../widgets/button_app_widget.dart';
import '../widgets/container_auth_widget.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/default_scaffold.dart';
import '../widgets/picker_dialog.dart';
import '../../user/widgets/dialog_widget.dart';

import '../widgets/textfield_app.dart';
import 'auth/widgets/circle_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({
    super.key,
    this.showNourIcon = false,
  });

  final bool showNourIcon;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Get.put(ProfileController());
    ProfileController profileController=Get.put(ProfileController());
    // ProfileController profileController=ProfileController.instance;
     profileController.refresh();

    return Scaffold(
        appBar: widget.showNourIcon
            ? CustomAppBarWidget(
                showBackButton: false,
                child: [
                  GetBuilder<ProfileController>(
                    init: profileController,
                    // init: profileController,
                    builder: (controller) {
                      return CircleProfilePictureWidget(
                        path: controller.profileImage?.path,
                      );
                    }
                  ),

                ],
              )
            : null,
        body: DefaultScaffoldWidget(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      Get.dialog(
                        DialogWidget(
                          title: AppString.logout,
                          text: AppString.areYouSureLogout,
                          buttonNoText: AppString.cancle,
                          buttonOkText: AppString.yes,
                          onPressed: () {
                            Get.lazyPut(() => AuthController());
                            AuthController.instance.signOut();
                          },
                        ),
                      );
                    },
                    label: Icon(
                      Icons.power_settings_new,
                      color: ColorManager.errorColor,
                    ),
                    icon: Text(
                      AppString.logout,
                      style: StylesManager.textNormalStyle(
                          color: ColorManager.primaryColor, size: 14.sp),
                    ),
                  ),
                ),
                Center(
                  child: GetBuilder<ProfileController>(
                      // init: profileController,
                      builder: (controller) {

                        return Column(
                          children: [
                            CircleProfilePictureWidget(
                              radius: 74.sp,
                              path: controller.profileImage?.path,
                            ),
                            const SizedBox(
                              height: AppSize.s10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      //delete Picker
                                      Get.dialog(
                                        DialogWidget(
                                          title: AppString.deletePhoto,
                                          text: AppString.areYouSureDeletePhoto,
                                          buttonNoText: AppString.cancle,
                                          buttonOkText: AppString.yes,
                                          onPressed: () {
                                            controller.deletePhoto();
                                            setState(() {});
                                          },
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.delete)),
                                IconButton(
                                  onPressed: () async {
                                    Get.dialog(
                                      PickerDialog(
                                        onChange:()=>  setState(() {}),
                                      ),
                                    );

                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: Text(
                    AppString.editProfile,
                    style: StylesManager.textBoldStyle(
                        size: 16.sp, color: ColorManager.primaryColor),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: DividerAuthWidget(),
                ),
                ContainerAuthWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.userName,
                          style: StylesManager.textNormalStyle(
                              size: 16.sp, color: ColorManager.primaryColor),
                        ),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          readOnly: true,
                          suffixIcon: widget.showNourIcon,
                          audioPath: AssetsManager.noorSound,
                          controller: profileController.userNameController,
                          hintText: AppString.userName,
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Text(
                          AppString.fullName,
                          style: StylesManager.textNormalStyle(
                              size: 16.sp, color: ColorManager.primaryColor),
                        ),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          suffixIcon: widget.showNourIcon,
                          audioPath: AssetsManager.noorSound,
                           controller: profileController.nameController,
                          hintText: AppString.userName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'خطأ!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Text(
                          AppString.email,
                          style: StylesManager.textNormalStyle(
                              size: 16.sp, color: ColorManager.primaryColor),
                        ),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          suffixIcon: widget.showNourIcon,

                          audioPath: AssetsManager.noorSound,
                           controller: profileController.emailController,
                          hintText: AppString.email,
                          validator: (value) {
                            print('object');
                            if (value!.isEmpty) {
                              return 'خطأ!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Text(
                          AppString.phone,
                          style: StylesManager.textNormalStyle(
                              size: 16.sp, color: ColorManager.primaryColor),
                        ),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          suffixIcon: widget.showNourIcon,
                          audioPath: AssetsManager.noorSound,
                          controller: profileController.phoneController,
                          hintText: AppString.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'خطأ!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        Text(
                          AppString.sex,
                          style: StylesManager.textNormalStyle(
                              size: 16.sp, color: ColorManager.primaryColor),
                        ),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          suffixIcon: widget.showNourIcon,
                          audioPath: AssetsManager.noorSound,
                          controller: profileController.genderController,
                          hintText: AppString.sex,
                          validator: (value) {
                            print('object');
                            if (value!.isEmpty) {
                              return 'خطأ!';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: ButtonAppWidget(
                      onPressed: () {
                        
                        profileController.updateUser();
                      }, text: AppString.saveEditing),
                ),
                const SizedBox(
                  height: AppSize.s100,
                ),
              ],
            ),
          ),
        ));
  }
}
