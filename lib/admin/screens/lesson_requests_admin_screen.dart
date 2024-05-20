import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/textfield_app.dart';
import '../widgets/educational_materials_management_widget.dart';
import '../widgets/lesson_request_widget.dart';

class LessonRequestsAdminScreen extends StatelessWidget {
  const LessonRequestsAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElasticInDown(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSize.s60,
          ),
          Text(
            AppString.lessonRequests,
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
          Expanded(
            child: ContainerAuthWidget(
              child: ListView.builder(
                itemBuilder: (context, index) => LessonRequestWidget(
                  title : 'عنوان الدرس ${index+1}'
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
    );
  }
}

