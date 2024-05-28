import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/screens/auth/widgets/divider_auth_widgets.dart';
import 'package:sanad_app/app/widgets/button_app_widget.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

import '../widgets/textfield_app.dart';
import 'auth/widgets/circle_profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.showNourIcon = false,
  });

  final bool showNourIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: !showNourIcon?CustomAppBarWidget(
          showBackButton: false,
          child: [
            CircleProfilePictureWidget(
              path:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS37JAC_YF1l4Nih5_FG15JI_EuFVRvVsveZKTGBNsmfqyeLGzTKMWY-prH8CGsLkxbb4&usqp=CAU',
            )
          ],
        ):null,
        body: DefaultScaffoldWidget(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {},
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
                 child: Column(
                   children: [
                     CircleProfilePictureWidget(
                       radius: 74.sp,
                       path:
                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS37JAC_YF1l4Nih5_FG15JI_EuFVRvVsveZKTGBNsmfqyeLGzTKMWY-prH8CGsLkxbb4&usqp=CAU',
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
                             },
                             icon: Icon(Icons.delete)),
                         IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                       ],
                     ),
                   ],
                 ),
               ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
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
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: DividerAuthWidget(),
                ),
                ContainerAuthWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.fullName,
                          style: StylesManager.textNormalStyle(
                              size: 16.sp, color: ColorManager.primaryColor),
                        ),
                        const DividerAuthWidget(),
                        TextFiledApp(

                          suffixIcon: showNourIcon,
                          audioPath: AssetsManager.noorSound,
                          // controller: authController.emailController,
                          hintText: AppString.userName,
                          validator: (value) {
                            print('object');
                            if (value!.isEmpty) {
                              return 'خطأ!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSize.s10,),
                        Text(
                          AppString.email,
                          style: StylesManager.textNormalStyle(
                              size: 16.sp, color: ColorManager.primaryColor),
                        ),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          suffixIcon: showNourIcon,

                          audioPath: AssetsManager.noorSound,
                          // controller: authController.emailController,
                          hintText: AppString.email,
                          validator: (value) {
                            print('object');
                            if (value!.isEmpty) {
                              return 'خطأ!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSize.s10,),

                        Text(
                          AppString.phone,
                          style: StylesManager.textNormalStyle(
                              size: 16.sp, color: ColorManager.primaryColor),
                        ),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          suffixIcon: showNourIcon,
                          audioPath: AssetsManager.noorSound,
                          // controller: authController.emailController,
                          hintText: AppString.phone,
                          validator: (value) {
                            print('object');
                            if (value!.isEmpty) {
                              return 'خطأ!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSize.s10,),

                        Text(
                          AppString.sex,
                          style: StylesManager.textNormalStyle(
                              size: 16.sp, color: ColorManager.primaryColor),
                        ),
                        const DividerAuthWidget(),
                        TextFiledApp(
                          suffixIcon: showNourIcon,
                          audioPath: AssetsManager.noorSound,
                          // controller: authController.emailController,
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
                      onPressed: () {}, text: AppString.saveEditing),
                ),
                const SizedBox(height: AppSize.s100,),

              ],
            ),
          ),
        ));
  }
}
