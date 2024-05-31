import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanad_app/app/controller/profile_controller.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';

import '../screens/auth/widgets/divider_auth_widgets.dart';

class PickerDialog extends GetView<ProfileController> {
  const PickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p40),
            child: ContainerAuthWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  Text(
                    AppString.pickPhoto,
                    style: StylesManager.textBoldStyle(
                        size: 16.sp, color: ColorManager.primaryColor),
                  ),
                  DividerAuthWidget(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.camera_alt_outlined),
                    title: Text(AppString.pickFromCamera),
                    onTap: (){
                      controller.pickPhoto(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.insert_photo_outlined),
                    title: Text(AppString.pickFromGallery),
                    onTap: (){
                      controller.pickPhoto(ImageSource.gallery);
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () => Get.back(), child: Text(AppString.cancle)),
                    ],
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
