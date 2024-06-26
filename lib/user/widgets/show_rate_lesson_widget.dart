import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/controller/profile_controller.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/assets_manager.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/widgets/container_auth_widget.dart';

import '../../app/models/lesson_model.dart';
import 'rate_dialog_widget.dart';

class ShowRateLessonWidget extends StatelessWidget {
  const ShowRateLessonWidget({
    super.key,
    required this.lessonName,
    required this.lesson,
  });

  final String lessonName;
  final LessonModel? lesson;

  @override
  Widget build(BuildContext context) {
    ProfileController profileController=Get.put(ProfileController());
    // String? uid=ProfileController.instance.currentUser.value?.uid;
    String? uid=profileController.currentUser.value?.uid;
    return ContainerAuthWidget(
      child: ListTile(
        trailing:
        (lesson?.mapRateLessons.containsKey(uid)??false)?
        TextButton.icon(
            onPressed: () {

              Get.dialog(RateDialogWidget(
                degreeRate: (lesson?.getRateByUser(uid!)??0)*10~/(lesson?.questions.length??3),
              ));
            },
            icon: Image.asset(
              AssetsManager.showEyeIcon,
              width: 20.sp,
              height: 20.sp,
              fit: BoxFit.cover,
            ),
            label: Text(AppString.myRateLesson
            )
        )
       : TextButton.icon(
            onPressed:null,
            icon: Image.asset(
              AssetsManager.emptyBoxIcon,
              width: 20.sp,
              height: 20.sp,
              fit: BoxFit.cover,
            ),
            label: Text(AppString.notFoundRate
            )
        ),
        contentPadding: EdgeInsets.zero,
        title: Text(
          lessonName,
          style: StylesManager.textBoldStyle(
              color: ColorManager.primaryColor, size: 14.sp),
        ),
      ),
    );
  }
}
