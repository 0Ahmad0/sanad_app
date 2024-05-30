import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/controller/user_controller.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';
import 'package:sanad_app/user/widgets/show_rate_lesson_widget.dart';

import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/textfield_app.dart';

class RateLessonScreen extends StatelessWidget {
  const RateLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rateController = Get.put(()=>UserController());
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
                      AppString.showRateLesson,
                      style: StylesManager.textBoldStyle(
                          color: ColorManager.primaryColor, size: 16.sp),
                    ),
                    DividerAuthWidget(),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    TextFiledApp(
                      // controller: rateController.searchController,
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
                      itemBuilder: (context, index) => ShowRateLessonWidget(lessonName: 'الدرس ${index+1}'),
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
