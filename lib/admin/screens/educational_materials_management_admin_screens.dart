import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/controller/lessons_controller.dart';
import '../../app/core/route/app_route.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/models/lesson_model.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/constants_widgets.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/empty_widget.dart';
import '../../app/widgets/textfield_app.dart';
import '../widgets/educational_materials_management_widget.dart';

class EducationalMaterialsManagementAdminScreen extends StatefulWidget {
  const EducationalMaterialsManagementAdminScreen({super.key});

  @override
  State<EducationalMaterialsManagementAdminScreen> createState() => _EducationalMaterialsManagementAdminScreenState();
}

class _EducationalMaterialsManagementAdminScreenState extends State<EducationalMaterialsManagementAdminScreen> {
  late LessonsController controller;
  void initState() {
    controller = Get.put(LessonsController());
    controller.onInit();
    super.initState();
  }

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
              controller: controller.searchController,
              onChanged: (_)=>controller.filterLessons(term: controller.searchController.value.text),
              iconData: Icons.search,
              hintText: AppString.search,
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          Expanded(
            child: ContainerAuthWidget(
              child:  StreamBuilder<QuerySnapshot>(
                  stream: controller.getLessons,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return    ConstantsWidgets.circularProgress();
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        ConstantsWidgets.circularProgress();
                        controller.lessons.items.clear();

                        if (snapshot.data!.docs.length > 0) {
                          controller.lessons.items =
                              LessonsModel.fromJson(snapshot.data!.docs).items;
                        }
                        controller.filterLessons(term: controller.searchController.value.text);
                        return
                          GetBuilder<LessonsController>(
                              builder: (LessonsController lessonsController)=>
                              (lessonsController.lessonsWithFilter.items.isEmpty ?? true)
                                  ?EmptyWidget(
                                  text: AppString.infoNotLessonYet)
                                  :

                              buildLessons(context, controller.lessonsWithFilter.items ?? []));
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  }),
            ),
          ),


          const SizedBox(
            height: AppSize.s20,
          ),
        ],
      ),
    );
  }

  Widget buildLessons(BuildContext context,List<LessonModel> items){
    return

      ListView.builder(
        itemBuilder: (context, index) => EducationalMaterialsManagementWidget(
          name: '${items[index].name}',
          lesson: items[index],
        ),
        itemCount: items.length,
      );
  }
}
