import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';

import '../../app/controller/admin_controller.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/models/question_model.dart';
import '../../app/widgets/custom_appbar_widget.dart';
import '../../app/widgets/default_scaffold.dart';
import '../../app/widgets/empty_widget.dart';

class AddQuestionsAdminScreenOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: controller.questions.isEmpty
            ? EmptyWidget(
          text: AppString.noQuestionFoundYet,
        )
            : GetBuilder<AdminController>(builder: (adminController) {
                return StatefulBuilder(builder: (context, setStateQuestion) {
                  return ReorderableColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        List.generate(adminController.questions.length, (index) {
                      return QuestionWidget(question: adminController.questions[index], index: index);
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

}


class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
    required this.index,
  });

  final Question question;
  final int index;

  @override
  Widget build(BuildContext context) {
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
                  StatefulBuilder(
                      builder: (context,setStateOptions) {
                        return Column(
                          children:
                          List.generate(question.options.length, (optionIndex) {

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

                          }),
                        );
                      }
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
