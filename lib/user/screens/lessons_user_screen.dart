import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';
import 'package:sanad_app/app/widgets/textfield_app.dart';
import 'package:sanad_app/user/widgets/show_lesson_widget.dart';

import '../../admin/widgets/lesson_widget.dart';
import '../../app/controller/user_controller.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';

class LessonUserScreen extends StatelessWidget {
  const LessonUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessonController = Get.put(UserController());
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Padding(
               padding: const EdgeInsets.all(AppPadding.p20),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Text(
                     AppString.showLessons,
                     style: StylesManager.textBoldStyle(
                         color: ColorManager.primaryColor, size: 16.sp),
                   ),
                   DividerAuthWidget(),
                   const SizedBox(
                     height: AppSize.s20,
                   ),
                   TextFiledApp(
                     controller: lessonController.searchController,
                     hintText: AppString.search,
                     iconData: Icons.search,
                     noPrefixIcon: false,
                   ),

                 ],
               ),
             ),
              Expanded(
                  child: ContainerAuthWidget(
                child: ListView.separated(
                  separatorBuilder: (_, __) => DividerAuthWidget(),
                  itemBuilder: (context, index) => ShowLessonWidget(lessonName: 'الدرس ${index+1}'),
                  itemCount: 10,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

