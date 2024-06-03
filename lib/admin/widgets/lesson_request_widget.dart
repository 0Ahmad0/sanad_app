import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/screens/auth/widgets/divider_auth_widgets.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';

import '../../app/controller/lesson_requests_admin_controller.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/models/lesson_model.dart';

class LessonRequestWidget extends StatelessWidget {
  const LessonRequestWidget({
    super.key,
    required this.title, this.lesson,
  });

  final String title;
  final LessonModel? lesson;

  @override
  Widget build(BuildContext context) {
    return ContainerAuthWidget(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: StylesManager.textNormalStyle(
                  size: 12.sp, color: ColorManager.primaryColor),
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppPadding.p100),
              child: DividerAuthWidget(),
            )
          ],
        ),
        subtitle: Row(
          children: [
            FittedBox(
              child: TextButton.icon(
                  onPressed: () {
                    lesson!=null?
                    Get.put(LessonsRequestsAdminController()).
                    ChangeStatus(context, lesson: lesson!, status: StatusLesson.rejected)
                        :'';
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
                    lesson!=null?
                    Get.put(LessonsRequestsAdminController()).
                    ChangeStatus(context, lesson: lesson!, status: StatusLesson.accepted)
                        :'';
                  },
                  icon: CircleAvatar(
                      radius: 10.sp,
                      backgroundColor: ColorManager.successColor,
                      child: Icon(
                        Icons.check,
                        size: 14.sp,
                        color: ColorManager.whiteColor,
                      )),
                  label: Text(
                    AppString.addLesson,
                    style: StylesManager.textNormalStyle(
                        color: ColorManager.secondaryColor,
                        size: 10.sp
                    ),
                  )),
            ),

          ],
        ),
      ),
    );
  }
}
