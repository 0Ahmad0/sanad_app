import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/widgets/empty_widget.dart';

import '../../app/controller/lesson_questions_admin_controller.dart';
import '../../app/controller/lessons_controller.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/models/lesson_model.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/constants_widgets.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/textfield_app.dart';
import '../widgets/lesson_widget.dart';
class QuestionsManageAdminScreen extends StatefulWidget {
  const QuestionsManageAdminScreen({super.key});

  @override
  State<QuestionsManageAdminScreen> createState() => _QuestionsManageAdminScreenState();
}

class _QuestionsManageAdminScreenState extends State<QuestionsManageAdminScreen> {
  late LessonsController controller;
  void initState() {
    controller = Get.put(LessonsController());
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
          Text(
            AppString.questionManagement,
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
                          Get.put(LessonQuestionsController()).updateLesson( controller.lessons.items??[]);
                        }
                        controller.filterLessons(term: controller.searchController.value.text);

                        return
                          GetBuilder<LessonsController>(
                              builder: (LessonsController lessonsController)=>
                              (lessonsController.lessonsWithFilter.items.isEmpty ?? true)
                                  ? EmptyWidget(text: AppString.infoNotLessonYet,)
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
        itemBuilder: (context, index) => LessonWidget(
          name: '${items[index].name}',
          lesson: items[index],
        ),
        itemCount: items.length,
      );
  }
}
