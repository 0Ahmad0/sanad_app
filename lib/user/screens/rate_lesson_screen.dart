import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/controller/user_controller.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';
import 'package:sanad_app/user/widgets/show_rate_lesson_widget.dart';

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

class RateLessonScreen extends StatefulWidget {
  const RateLessonScreen({super.key});

  @override
  State<RateLessonScreen> createState() => _RateLessonScreenState();
}

class _RateLessonScreenState extends State<RateLessonScreen> {
  late LessonsController controller;
  void initState() {
    controller = Get.put(LessonsController());
    super.initState();
  }
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
                      controller: controller.searchController,
                      onChanged: (_)=>controller.filterLessons(term: controller.searchController.value.text),

                      hintText: AppString.search,
                      iconData: Icons.search,
                      noPrefixIcon: false,
                    ),

                  ],
                ),
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
                        }) ,
                  ))
            ],
          ),
        ),
      ),

    );
  }
  Widget buildLessons(BuildContext context,List<LessonModel> items){
    return
      ListView.separated(
        separatorBuilder: (_, __) => DividerAuthWidget(),
        itemBuilder: (context, index) => ShowRateLessonWidget(lessonName: '${items[index].name}',
          lesson: items[index],
        ),
        itemCount: items.length,
      );
    ;

  }
}
