import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';
import 'package:sanad_app/user/widgets/dialog_widget.dart';

import '../../app/controller/lesson_questions_user_controller.dart';
import '../../app/controller/user_controller.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/models/question_model.dart';
import '../../app/widgets/empty_widget.dart';

class ShowQuestionUserScreen extends StatelessWidget {
  const ShowQuestionUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(() => UserController());
    LessonQuestionUserController lessonQuestionUserController = Get.put( LessonQuestionUserController());
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
        child: GetBuilder<LessonQuestionUserController>(

          builder:(controller){
            questions=lessonQuestionUserController.lesson?.questions??[];
           return
           //TODO show only 3 question
             questions.length!=3?
             // questions.length==0?
             EmptyWidget(
               text: AppString.noQuestionFoundYet,
             ):
             ListView.builder(
            itemCount:questions.length,
            itemBuilder: (context, index) =>
                QuestionWidget(question: questions[index], index: index),
          );},
        ),
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
   QuestionWidget({
    super.key,
    required this.question,
    required this.index,
  });

  final Question question;
  final int index;
  int? selectOptionIndex;
  int? selectedOptionIndex;
  String? correctAnswer;
  bool? isCorrect;

  @override
  Widget build(BuildContext context) {
    LessonQuestionUserController lessonQuestionUserController = Get.put( LessonQuestionUserController());
    selectedOptionIndex=selectOptionIndex= lessonQuestionUserController.lesson?.getSelectOptionByQuestion(
        lessonQuestionUserController.idUser??'',index);
    correctAnswer= lessonQuestionUserController.lesson!.questions[index].options[lessonQuestionUserController.lesson!.questions[index].correctOptionIndex];
    isCorrect=lessonQuestionUserController.lesson?.questions[index].correctOptionIndex==lessonQuestionUserController.lesson?.getSelectOptionByQuestion(lessonQuestionUserController.idUser??'', index);
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
          StatefulBuilder(builder: (context, setStateOptions) {

         return ContainerAuthWidget(
            key: ValueKey(question),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                   Column(
                    children:
                        List.generate(question.options.length, (optionIndex) {

                      return RadioListTile(
                        title: Text(question.options[optionIndex]),
                        value: optionIndex,

                         // activeColor:ColorManager.successColor,
                        groupValue:selectOptionIndex,//question.correctOptionIndex,
                        onChanged: (value) {
                          setStateOptions(() {
                            // question.correctOptionIndex = value as int;
                            if(selectedOptionIndex==null)
                            selectOptionIndex = value as int;
                          });
                        },
                      );
                    }),
                  ),
                selectedOptionIndex!=null?
                AnswerInfoBox(correctValue:correctAnswer,isCorrect: isCorrect,)
              :  TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:selectOptionIndex==null?ColorManager.greyColor: ColorManager.successColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)
                    ),
                    minimumSize: Size(double.infinity,AppSize.s50)
                  ),
                  onPressed:
                  selectOptionIndex==null?
                      null
                      :() {

                    lessonQuestionUserController.answerQuestion(context, questionIndex: index, selectOptionIndex: selectOptionIndex!);
                    // Get.dialog(DialogWidget(
                    //     title: 'إجابة خاطئة',
                    //     text : 'الاجابة الصحيحية هي',
                    //     buttonNoText: AppString.ok,
                    //     onPressed: null
                    // ));
                  },

                  child: Text(
                    AppString.send,
                    style: StylesManager.textNormalStyle(
                        color: ColorManager.whiteColor),
                  ),
                )
              ],
            ));},
          ),
        ],
      ),
    );
  }

}

class AnswerInfoBox extends StatelessWidget {
  const AnswerInfoBox({super.key,  this.correctValue,this.isCorrect=true});
  final String? correctValue;
  final bool? isCorrect;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(AppPadding.p4),
      decoration: BoxDecoration(
        
        border: Border.all(
          color: isCorrect==null?ColorManager.greyColor:isCorrect!  ? ColorManager.successColor : ColorManager.errorColor,
          width: 2, // عرض الحواف
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      height: AppSize.s50,
      child:
      isCorrect==null?
      Center(
        child: Text(
          'لا يوجد إجابة',
        ),
      )
      :isCorrect!?Center(
        child: Text(
          AppString.correctAnswer,
        ),
      ):Text(
        AppString.inCorrectAnswer
        +'\n'
        +'الإجابة الصحيحة: '
        +'$correctValue',
      ),
    );
  }
}

