import 'package:flutter/cupertino.dart';
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

import '../../app/controller/lesson_questions_admin_controller.dart';
import '../../app/models/question_model.dart';
import '../../app/widgets/empty_widget.dart';
import '../../user/widgets/dialog_widget.dart';
import 'add_question_screen.dart';

class AddQuestionsAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LessonQuestionsController());
     controller.refreshQuestion();

    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: controller.lesson?.questions.isEmpty??true
            ? EmptyWidget(
          text: AppString.noQuestionFoundYet,
        )
            : GetBuilder<LessonQuestionsController>(builder: (lessonQuestionsController) {
                return StatefulBuilder(builder: (context, setStateQuestion) {
                  return ReorderableColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        List.generate(controller.lesson!.questions.length, (index) {
                      return QuestionWidget(key:Key('$index'),question: controller.lesson!.questions[index], index: index);
                    }),
                    onReorder: (int oldIndex, int newIndex) {
                      setStateQuestion(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final item = controller.lesson!.questions.removeAt(oldIndex);
                        controller.lesson!.questions.insert(newIndex, item);
                      });
                      controller.updateQuestions(context, lesson:  controller.lesson);

                      // controller.deleteQuestion(context, question: controller.lesson!.questions[oldIndex]);
                      // setStateQuestion(() {
                      //   if (newIndex > oldIndex) {
                      //     newIndex -= 1;
                      //   }
                      //   final item = adminController.questions.removeAt(oldIndex);
                      //   adminController.questions.insert(newIndex, item);
                      // });
                    },
                  );
                });
              }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorManager.secondaryColor,
        onPressed: () =>
        //TODO add only 3 question
        (controller.lesson?.questions.length??0)>=3?

        Get.dialog(DialogWidget(
            title: 'خطأ',
            text : 'لا يمكنك إضافة أكثر من 3 أسئلة',
            buttonNoText: AppString.ok,
            onPressed: null
        ))
            :Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                AddQuestionPage(
                  onSave: (question) {
                    controller.addQuestion(context,question: question);
                    // questions.add(question);
                    // update();
                  },
                ),
          ),
        ),
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
    final controller = Get.put(LessonQuestionsController());

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
                                controller.updateQuestion(context, index: index, question: question);
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
