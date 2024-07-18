import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/controller/lesson_controller.dart';
import 'package:sanad_app/app/core/utils/app_constant.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';
import 'package:video_player/video_player.dart';

import '../../user/widgets/dialog_widget.dart';

class ShowMediaLessonsScreen extends StatelessWidget {
  const ShowMediaLessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LessonController());
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ContainerAuthWidget(
                child: PageView.builder(
                    itemCount: controller.lesson?.imagesPath.length ?? 0,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Stack(
                            children: [
                              Image.network(
                                controller.lesson!.imagesPath[index],
                                width: double.maxFinite,
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => DialogWidget(
                                            text: AppString.deletePhoto,
                                            title:
                                                AppString.areYouSureDeletePhoto,
                                            onPressed: () {
                                            // controller.lesson!.imagesPath.removeAt(index);
                                            // Get.back();
                                            },
                                          ));
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.delete,
                                    color: ColorManager.errorColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
              ),
            ),
            Divider(),
            Expanded(child: ContainerAuthWidget(
              child: SizedBox(),
            )),
            Divider(),
            Expanded(child: ContainerAuthWidget(
              child: SizedBox(),
            )),
          ],
        ),
      ),
    );
  }
}

