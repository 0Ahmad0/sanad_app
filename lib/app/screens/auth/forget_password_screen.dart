import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../core/utils/app_string.dart';
import 'widgets/divider_auth_widgets.dart';
import '../../widgets/button_app_widget.dart';
import '../../widgets/container_auth_widget.dart';
import '../../widgets/custom_appbar_widget.dart';
import '../../widgets/default_scaffold.dart';

import '../../controller/forget_password_controller.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/styles_manager.dart';
import '../../core/utils/values_manager.dart';
import '../../widgets/textfield_app.dart';
import 'widgets/email_recovery_success_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppSize.s10,
                ),
                Text(
                  AppString.reInsertPassword,
                  style: StylesManager.textBoldStyle(
                      size: 20.sp, color: ColorManager.primaryColor),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                DividerAuthWidget(
                  color: ColorManager.secondaryColor.withOpacity(.5),
                ),
                SizedBox(
                  height: AppSize.s60.sp,
                ),
                ContainerAuthWidget(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppSize.s40.sp,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: AppString.pleaseInsertYourEmail,
                            style: StylesManager.textNormalStyle(
                                color: ColorManager.primaryColor, size: 16.sp),
                          ),
                          TextSpan(
                            text: '*',
                            style: StylesManager.textNormalStyle(
                                color: ColorManager.errorColor, size: 18.sp),
                          ),
                        ])),
                        const DividerAuthWidget(),
                        const SizedBox(
                          height: AppSize.s10,
                        ),
                        TextFiledApp(
                          controller: controller.emailController,
                          hintText: AppString.emailExample,
                          validator:(value)=> AuthController.instance.validateEmail(value!),
                        ),
                        SizedBox(
                          height: AppSize.s60.sp,
                        ),
                        Text(
                          AppString.thisMarkMeainingFiledIsRequired,
                          style: StylesManager.textBoldStyle(
                              color: ColorManager.errorColor, size: 10.sp),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s40.sp,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p40),
                  child: ButtonAppWidget(
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {

                         bool? isSend= await controller.send();
                         if(isSend??false)
                          showModalBottomSheet(

                            clipBehavior: Clip.hardEdge,
                              context: context,
                              builder: (_) =>
                                  EmailRecoverySuccessBottomSheetWidget());
                        }
                      },
                      text: AppString.send),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
