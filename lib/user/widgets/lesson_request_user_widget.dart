import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/screens/auth/widgets/divider_auth_widgets.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';

import '../../app/controller/lessons_controller.dart';
import '../../app/core/route/app_route.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/models/lesson_model.dart';

class LessonRequestUserWidget extends StatelessWidget {
  const LessonRequestUserWidget({
    super.key,
    required this.title,
    required this.lesson,
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
              title,
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              trailing: Visibility(
                visible: lesson?.dateTime!=null,
                child: Text(
                  DateFormat.yMd().format(lesson?.dateTime??DateTime.now()),
                  style: StylesManager.textNormalStyle(
                    color: ColorManager.primaryColor,
                    size: 12.sp
                  ),
                ),
              ),
              title: Text.rich(TextSpan(children: [
                TextSpan(
                  text: AppString.statusLessons,
                ),
                TextSpan(
                    text: lesson?.status??'مقبول',
                    style: StylesManager.textNormalStyle(
                        color:lesson?.statusColor?? ColorManager.successColor, size: 12.sp)),
              ])),
            ),
            Visibility(
              visible: lesson?.statusEnum==StatusLesson.pending,
              child: Row(
                children: [
                  FittedBox(
                    child: TextButton.icon(
                        onPressed: () {
                          Get.toNamed(AppRoute.addLessonUserRoute,arguments: {'lesson':lesson});
                        },
                        icon: CircleAvatar(
                            radius: 10.sp,
                            backgroundColor: ColorManager.secondaryColor,
                            child: Icon(
                              Icons.edit,
                              size: 14.sp,
                              color: ColorManager.whiteColor,
                            )),
                        label: Text(
                          AppString.edit,
                          style: StylesManager.textNormalStyle(
                              color: ColorManager.secondaryColor, size: 10.sp),
                        )),
                  ),
                  FittedBox(
                    child: TextButton.icon(
                        onPressed: () {
                          Get.put(LessonsController()).deleteLesson(context, idLesson: lesson?.id);
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
                              color: ColorManager.secondaryColor, size: 10.sp),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
