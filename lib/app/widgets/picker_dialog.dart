import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/profile_controller.dart';
import '../core/utils/app_string.dart';
import '../core/utils/color_manager.dart';
import '../core/utils/styles_manager.dart';
import '../core/utils/values_manager.dart';
import 'container_auth_widget.dart';
import 'package:animate_do/animate_do.dart';
import '../screens/auth/widgets/divider_auth_widgets.dart';

// class PickerDialog extends GetView<ProfileController> {
class PickerDialog extends GetView<ProfileController> {
  const PickerDialog( {super.key,this.onChange});
  final VoidCallback? onChange;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BounceInDown(
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
                      onTap: () async {
                       await  controller.pickPhoto(ImageSource.camera);
                        onChange?.call();
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.insert_photo_outlined),
                      title: Text(AppString.pickFromGallery),
                      onTap: () async {
                         await controller.pickPhoto(ImageSource.gallery);
                         onChange?.call();
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
      ),
    );
  }
}
