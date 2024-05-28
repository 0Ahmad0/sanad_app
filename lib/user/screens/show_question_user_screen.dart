import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';
import 'package:sanad_app/user/widgets/dialog_widget.dart';

import '../../app/controller/user_controller.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/models/question_model.dart';

class ShowQuestionUserScreen extends StatelessWidget {
  const ShowQuestionUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(() => UserController());
    List<Question> questions = [
      Question(
          text: 'text', options: ['1', '2', '3', '4'], correctOptionIndex: 3),
      Question(
          text: 'text', options: ['1', '2', '3', '4'], correctOptionIndex: 3),
      Question(
          text: 'text', options: ['1', '2', '3', '4'], correctOptionIndex: 3),
    ];

    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) =>
              QuestionWidget(question: questions[index], index: index),
        ),
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
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        key: ValueKey(question),
        title: Text(
          AppString.question + ' ${index + 1}: ${question.text}',
          style:
              StylesManager.textNormalStyle(color: ColorManager.primaryColor),
        ),
        children: [
          ContainerAuthWidget(
            key: ValueKey(question),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatefulBuilder(builder: (context, setStateOptions) {
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
                }),

                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: ColorManager.successColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)
                    ),
                    minimumSize: Size(double.infinity,AppSize.s50)
                  ),
                  onPressed: () {
                    Get.dialog(DialogWidget(
                        title: 'إجابة خاطئة',
                        text : 'الاجابة الصحيحية هي',
                        buttonNoText: AppString.ok,
                        onPressed: null
                    ));
                  },
                  child: Text(
                    AppString.send,
                    style: StylesManager.textNormalStyle(
                        color: ColorManager.whiteColor),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
