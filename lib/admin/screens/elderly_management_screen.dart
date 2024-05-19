import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/screens/auth/widgets/divider_auth_widgets.dart';
import 'package:sanad_app/app/widgets/button_app_widget.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';
import 'package:sanad_app/app/widgets/textfield_app.dart';

import '../widgets/elderly_widget.dart';

class ElderlyManagementScreen extends StatelessWidget {
  const ElderlyManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSize.s60,
          ),
          Text(
            AppString.elderlyManagement,
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
          Expanded(
            child: ContainerAuthWidget(
              child: ListView.builder(
                itemBuilder: (context, index) => ElderlyWidget(
                  name: 'كبير السن ${index+1}',
                ),
                itemCount: 10,
              ),
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: ButtonAppWidget(onPressed: (){}, text: AppString.save),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
        ],
      ),
    );
  }
}

