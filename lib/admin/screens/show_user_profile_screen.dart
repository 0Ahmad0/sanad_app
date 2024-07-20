import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/models/user_model.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/assets_manager.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/screens/auth/widgets/circle_profile_widget.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/custom_appbar_widget.dart';
import '../../app/widgets/default_scaffold.dart';
import '../../app/widgets/textfield_app.dart';
import '../../user/widgets/dialog_widget.dart';
import '../widgets/circle_user_profile_widget.dart';

class ShowUserProfileScreen extends StatefulWidget {
  ShowUserProfileScreen({
    super.key,
    this.showNourIcon = false,
  });

  final bool showNourIcon;
  @override
  State<ShowUserProfileScreen> createState() => _ShowUserProfileScreenState();
}

class _ShowUserProfileScreenState extends State<ShowUserProfileScreen> {
  UserModel? user;
  @override
  void initState() {
    user=Get.arguments['user'];
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:true
            ? CustomAppBarWidget(
                showBackButton: false,
                child: [
                  CircleProfilePictureWidget(
                    path: user?.photoUrl,
                  ),
                ],
              )
            : null,
        body: DefaultScaffoldWidget(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      CircleUserProfilePictureWidget(
                        radius: 74.sp,
                        url: user?.photoUrl,
                        name: user?.name,
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: AppSize.s10,
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                //   child: Text(
                //     AppString.editProfile,
                //     style: StylesManager.textBoldStyle(
                //         size: 16.sp, color: ColorManager.primaryColor),
                //   ),
                // ),
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
                          audioPath: AssetsManager.enterUserNameSound,
                          controller: TextEditingController(text: user?.userName),
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
                          readOnly: true,
                          suffixIcon: widget.showNourIcon,
                          audioPath: AssetsManager.enterFullNameSound,
                          controller: TextEditingController(text: user?.name),
                          hintText: AppString.fullName,
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
                          readOnly: true,
                          suffixIcon: widget.showNourIcon,
                          audioPath: AssetsManager.enterEmailSound,
                          controller: TextEditingController(text: user?.email),
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
                          readOnly: true,
                          suffixIcon: widget.showNourIcon,
                          audioPath: AssetsManager.enterPhoneNumberSound,
                          controller: TextEditingController(text: user?.phoneNumber),
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
                          readOnly: true,
                          suffixIcon: widget.showNourIcon,
                          audioPath: AssetsManager.enterPhoneNumberSound,
                          controller: TextEditingController(text: user?.gender),
                          hintText: AppString.sex,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'خطأ!';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
