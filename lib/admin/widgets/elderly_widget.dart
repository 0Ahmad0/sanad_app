import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/models/user_model.dart';
import '../../app/core/route/app_route.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/widgets/container_auth_widget.dart';

import '../../app/controller/users_controller.dart';
import '../../user/widgets/dialog_widget.dart';

class ElderlyWidget extends StatelessWidget {
   ElderlyWidget({
    super.key,
    required this.user,
  });

  final UserModel user;
  late UsersController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(UsersController());
    return FadeInRight(
      child: ContainerAuthWidget(
        child: Row(
          children: [
            Expanded(
              child: Text(
                user.name??'',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StylesManager.textNormalStyle(
                    color: ColorManager.primaryColor,
                    size: 12.sp
                ),
              ),
            ),
            Text('|'),
            Row(
              children: [
                FittedBox(
                  child: TextButton.icon(
                      onPressed: () {
                        Get.dialog(
                          DialogWidget(
                            title: AppString.deleteUser,
                            text: AppString.areYouSureDeleteUser,
                            buttonNoText: AppString.cancle,
                            buttonOkText: AppString.yes,
                            onPressed: () {

                              // controller.deleteUser();
                            },
                          ),
                        );
                      },
                      icon: CircleAvatar(
                        radius: 10.sp,
                          backgroundColor: ColorManager.errorColor,
                          child: Icon(
                            Icons.delete,
                            size: 14.sp,
                            color: ColorManager.whiteColor,
                          )),
                      label: Text(
                        AppString.delete,
                        style: StylesManager.textNormalStyle(
                          color: ColorManager.secondaryColor,
                          size: 10.sp
                        ),
                      )),
                ),
                FittedBox(
                  child: TextButton.icon(
                      onPressed: () {
                        Get.toNamed(AppRoute.ShowUserProfileAdminRoute,arguments: {'user':user});
                      },
                      icon: CircleAvatar(
                        radius: 10.sp,
                          backgroundColor: ColorManager.secondaryColor,
                          child: Icon(
                            Icons.remove_red_eye_rounded,
                            size: 14.sp,
                            color: ColorManager.whiteColor,
                          )),
                      label: Text(
                        AppString.show,
                        style: StylesManager.textNormalStyle(
                          color: ColorManager.secondaryColor,
                          size: 10.sp
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
