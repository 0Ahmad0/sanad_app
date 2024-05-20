import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/route/app_route.dart';

import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/button_app_widget.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/textfield_app.dart';
import '../widgets/educational_materials_management_widget.dart';

class EducationalMaterialsManagementAdminScreen extends StatelessWidget {
  const EducationalMaterialsManagementAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSize.s60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppString.educationalMaterialsManagement,
                overflow: TextOverflow.ellipsis,
                style: StylesManager.textBoldStyle(
                  color: ColorManager.primaryColor,
                  size: 20.sp,
                ),
              ),
              IconButton(onPressed: (){
                Get.toNamed(AppRoute.addLessonAdminRoute);
              }, icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorManager.primaryColor
                  )
                ),
                child: CircleAvatar(
                  backgroundColor: ColorManager.secondaryColor.withOpacity(.3),
                  child: Icon(Icons.add,color: ColorManager.primaryColor,),
                ),
              ))
            ],
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
                itemBuilder: (context, index) => EducationalMaterialsManagementWidget(
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
    );
  }
}
