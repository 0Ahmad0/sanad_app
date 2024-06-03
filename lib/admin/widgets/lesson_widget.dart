import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/route/app_route.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/models/lesson_model.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';

class LessonWidget extends StatelessWidget {
  const LessonWidget({
    super.key,
    required this.name,
     this.lesson,
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
            lesson?.description?.isNotEmpty??true?
                  lesson!.description!: ('----')
            ,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: StylesManager.textNormalStyle(
                size: 10.sp, color: ColorManager.secondaryColor),
          ),
          trailing: IconButton(
            onPressed: (){

              Get.toNamed(AppRoute.addQuestionsAdminRoute
              ,arguments: {'lesson':lesson});
            },
            icon: Icon(Icons.arrow_forward_ios_outlined),
          ),
        ),
      ),
    );
  }
}
