import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:sanad_app/app/controller/admin_controller.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

import '../../app/models/question_model.dart';

class AddQuestionsAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: controller.questions.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsManager.emptyBoxIcon,
                      width: 100.sp,
                      height: 100.sp,
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Text(
                      AppString.noQuestionFoundYet,
                    ),
                  ],
                ),
              )
            : GetBuilder<AdminController>(builder: (adminController) {
                return StatefulBuilder(builder: (context, setStateQuestion) {
                  return ReorderableColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        List.generate(adminController.questions.length, (index) {
                      return buildQuestionCard(
                          adminController.questions[index], index);
                    }),
                    onReorder: (int oldIndex, int newIndex) {
                      setStateQuestion(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final item = adminController.questions.removeAt(oldIndex);
                        adminController.questions.insert(newIndex, item);
                      });
                    },
                  );
                });
              }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorManager.secondaryColor,
        onPressed: () => controller.addQuestion(context),
        icon: Icon(Icons.add),
        label: Text(AppString.addQuestion),
      ),
    );
  }

  Widget buildQuestionCard(Question question, int index) {
    return Theme(
      key: ValueKey(question),
      data: ThemeData(
        dividerColor: Colors.transparent
      ),
      child: ExpansionTile(
        key: ValueKey(question),
        title: Text(
          AppString.question + ' ${index + 1}: ${question.text}',
          style: StylesManager.textNormalStyle(
            color: ColorManager.primaryColor
          ),
        ),
        children: [
          Card(
            key: ValueKey(question),
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Column(
                    children:
                        List.generate(question.options.length, (optionIndex) {
                      return StatefulBuilder(builder: (context, setStateOptions) {
                        return RadioListTile(
                          title: Text(question.options[optionIndex]),
                          value: optionIndex,
                          groupValue: question.correctOptionIndex,
                          onChanged: (value) {
                            setStateOptions(() {
                              question.correctOptionIndex = value as int;
                            });
                          },
                        );
                      });
                    }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
