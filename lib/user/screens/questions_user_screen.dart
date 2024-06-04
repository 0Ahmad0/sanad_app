import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

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
import '../widgets/lesson_user_widget.dart';
class QuestionsUserScreen extends StatefulWidget {
  const QuestionsUserScreen({super.key});

  @override
  State<QuestionsUserScreen> createState() => _QuestionsUserScreenState();
}

class _QuestionsUserScreenState extends State<QuestionsUserScreen> {
  late LessonsController controller;
  void initState() {
    controller = Get.put(LessonsController());
    super.initState();
  }
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
                    controller: controller.searchController,
                    onChanged: (_)=>controller.filterLessons(term: controller.searchController.value.text),

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
                    child:   StreamBuilder<QuerySnapshot>(
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
                              controller.lessons?.items.clear();

                              if (snapshot.data!.docs!.length > 0) {
                                controller.lessons?.items =
                                    LessonsModel.fromJson(snapshot.data!.docs!).items;
                              }
                              controller.filterLessons(term: controller.searchController.value.text);
                              return
                                GetBuilder<LessonsController>(
                                    builder: (LessonsController lessonsController)=>
                                    (lessonsController.lessonsWithFilter?.items?.isEmpty ?? true)
                                        ? ConstantsWidgets.emptyWidget(context,
                                        text: "No Lessons Yet")
                                        :

                                    buildLessons(context, controller.lessonsWithFilter?.items ?? []));
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
          ),
        ),
      ),
    );
  }

  Widget buildLessons(BuildContext context,List<LessonModel> items){
    return
      ListView.builder(
        itemBuilder: (context, index) => LessonUserWidget(
          name: '${items[index].name}',
          lesson: items[index],
        ),
        itemCount: items.length,
      );

  }
}
