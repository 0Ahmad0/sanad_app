import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/controller/lesson_requests_user_controller.dart';
import '../../app/core/route/app_route.dart';
import '../../app/core/utils/assets_manager.dart';
import '../../app/widgets/custom_appbar_widget.dart';
import '../../app/widgets/default_scaffold.dart';

import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/models/lesson_model.dart';
import '../../app/screens/auth/widgets/divider_auth_widgets.dart';
import '../../app/widgets/constants_widgets.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/textfield_app.dart';
import '../../main.dart';
import '../widgets/lesson_request_user_widget.dart';

class ManagingLessonUserScreen extends StatefulWidget {
  const ManagingLessonUserScreen({super.key});

  @override
  State<ManagingLessonUserScreen> createState() => _ManagingLessonUserScreenState();
}

class _ManagingLessonUserScreenState extends State<ManagingLessonUserScreen> {
  late LessonsRequestsUserController controller;
  void initState() {
    controller = Get.put(LessonsRequestsUserController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        child: [
          IconButton(
              onPressed: () async{
                await audio.play(AssetSource(AssetsManager.managementLessonsScreenSound));
              },
              icon: CircleAvatar(
                  backgroundColor: ColorManager.whiteColor,
                  child: Image.asset(AssetsManager.nourSoundIcon))),

        ],
      ),
      body: FadeInDown(
        child: DefaultScaffoldWidget(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.manageLesson,
                      overflow: TextOverflow.ellipsis,
                      style: StylesManager.textBoldStyle(
                        color: ColorManager.primaryColor,
                        size: 20.sp,
                      ),
                    ),
                    IconButton(onPressed: (){
                      Get.toNamed(AppRoute.addLessonUserRoute);
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
                Expanded(
                  child: ContainerAuthWidget(
                    child:StreamBuilder<QuerySnapshot>(
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
                                GetBuilder<LessonsRequestsUserController>(
                                    builder: (LessonsRequestsUserController lessonsController)=>
                                    (lessonsController.lessonsWithFilter.items.isEmpty ?? true)
                                        ? ConstantsWidgets.emptyWidget(context,
                                      text: "No Lesson Requesrs Yet",)
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
          ),
        ),
      ),
    );
  }

  Widget buildLessons(BuildContext context,List<LessonModel> items){
    return
      ListView.builder(
        itemBuilder: (context, index) => LessonRequestUserWidget(
          title :'${items[index].name}',
          lesson: items[index],
        ),
        itemCount: items.length,
      );
  }
}

