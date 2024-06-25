import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/route/app_route.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/models/lesson_model.dart';
import 'package:sanad_app/app/widgets/constants_widgets.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';

import 'show_media_lesson_widget.dart';

class ShowLessonWidget extends StatelessWidget {
  const ShowLessonWidget({
    super.key,
    required this.lessonName, this.lesson,
  });

  final String lessonName;
  final LessonModel? lesson;

  @override
  Widget build(BuildContext context) {
    return ContainerAuthWidget(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          lessonName,
          style: StylesManager.textBoldStyle(
              color: ColorManager.primaryColor, size: 14.sp),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShowMediaLessonWidget(
              image: AssetsManager.showEyeIcon,
              title: AppString.show,
              onTap: (){
                Get.toNamed(AppRoute.showTextUserRoute,arguments: {'lesson':lesson});
              },
            ),
            Visibility(
              // visible: lesson?.filePath!=null,
              child: ShowMediaLessonWidget(
                image: AssetsManager.adminSoundIcon,
                title: AppString.playLessonSound,
                isActive: lesson?.filePath!=null,
                onTap: (){
                  if(lesson?.filePath!=null){
                    Get.toNamed(AppRoute.showAudioUserRoute,parameters: {'path':lesson?.filePath??''});
                  }
                  else{
                    ConstantsWidgets.TOAST(null,title:  AppString.message_sorry,textToast:AppString.notFoundSound ,state:false );

                  }
                },
              ),
            ),
            Visibility(
              // visible: lesson?.videoPath!=null,
              child: ShowMediaLessonWidget(
                image: AssetsManager.adminVideoIcon,
                title: AppString.playLessonVideo,
                isActive: lesson?.videoPath!=null,
                onTap: (){
                  if(lesson?.videoPath!=null){
                    Get.toNamed(AppRoute.showVedioUserRoute,parameters: {'path':lesson?.videoPath??''});
                  }
                  else{
                    ConstantsWidgets.TOAST(null,title:  AppString.message_sorry,textToast:AppString.notFoundVideo ,state:false );

                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

