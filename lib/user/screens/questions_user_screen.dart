import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/textfield_app.dart';
import '../widgets/lesson_user_widget.dart';
class QuestionsUserScreen extends StatelessWidget {
  const QuestionsUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: FadeInDown(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  AppString.questions,
                  overflow: TextOverflow.ellipsis,
                  style: StylesManager.textBoldStyle(
                    color: ColorManager.primaryColor,
                    size: 20.sp,
                  ),
                ),

                const DividerAuthWidget(),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p12),
                  child: TextFiledApp(
                    suffixIcon: false,
                    iconData: Icons.search,
                    hintText: AppString.search,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppString.selectLesson,
                  overflow: TextOverflow.ellipsis,
                  style: StylesManager.textBoldStyle(
                    color: ColorManager.primaryColor,
                    size: 16.sp,
                  ),
                ),
                const DividerAuthWidget(),
                Expanded(
                  child: ContainerAuthWidget(
                    child: ListView.builder(
                      itemBuilder: (context, index) => LessonUserWidget(
                        name: 'اسم الدرس ${index+1}',
                      ),
                      itemCount: 10,
                    ),
                  ),
                ),



                const SizedBox(
                  height: AppSize.s20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
