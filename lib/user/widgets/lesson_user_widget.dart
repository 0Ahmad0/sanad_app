import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/core/route/app_route.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/widgets/container_auth_widget.dart';

import '../../app/models/lesson_model.dart';

class LessonUserWidget extends StatelessWidget {
  const LessonUserWidget({
    super.key,
    required this.name,
    required this.lesson,
  });

  final String name;
  final LessonModel? lesson;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: ContainerAuthWidget(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(name),
          subtitle: Text(
            '----',
            style: StylesManager.textNormalStyle(
                size: 10.sp, color: ColorManager.secondaryColor),
          ),
          trailing: IconButton(
            onPressed: (){
              Get.toNamed(AppRoute.showQuestionUserRoute,arguments: {'lesson':lesson});
            },
            icon: Icon(Icons.arrow_forward_ios_outlined),
          ),
        ),
      ),
    );
  }
}
