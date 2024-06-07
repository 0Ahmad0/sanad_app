

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanad_app/app/controller/profile_controller.dart';
import 'package:sanad_app/app/core/utils/app_constant.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/models/question_model.dart';
import 'package:sanad_app/app/models/user_model.dart';

import '../../user/widgets/constants_widgets.dart';
import '../../user/widgets/dialog_widget.dart';
import '../models/lesson_model.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';


class LessonQuestionUserController extends GetxController{

  LessonModel? lesson=Get.arguments?['lesson'];
  String? idUser;

  refreshQuestion(){
    lesson=Get.arguments?['lesson'];
  }

  @override
  void onInit() {
    lesson=Get.arguments?['lesson'];
    idUser=Get.put(ProfileController()).currentUser.value?.uid;
    super.onInit();
    }


  answerQuestion(BuildContext context,{required int questionIndex,   required int selectOptionIndex}) async {
    ConstantsWidgets.showLoading();
    lesson?.answerQuestion(idUser??'', questionIndex, selectOptionIndex);
    var result =await FirebaseFun
        .updateLesson(lesson: lesson!,);
    Get.back();
    if(result['status']){
      if(lesson?.questions[questionIndex].correctOptionIndex!=lesson?.getSelectOptionByQuestion(idUser??'', questionIndex))
        Get.dialog(DialogWidget(
            title: 'إجابة خاطئة',
            text : 'الاجابة الصحيحية هي: '+'(${lesson!.questions[questionIndex].correctOptionIndex+1} - ${
                lesson!.questions[questionIndex].options[lesson!.questions[questionIndex].correctOptionIndex]
            })',
            buttonNoText: AppString.ok,
            onPressed: null
        ));
      else
        Get.dialog(DialogWidget(
            title: 'أحسنت',
            text : 'إجابة صحيحة',
            buttonNoText: AppString.ok,
            onPressed: null
        ));
      // ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast('تمت إضافة السؤال بنجاح'),state: result['status']);
    }else{
      lesson?.removeAnswer(idUser??'', questionIndex, selectOptionIndex);
      ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    }
    update();
    return result;
  }


  deleteQuestion(BuildContext context,{required Question question}) async {
    ConstantsWidgets.showLoading();
    lesson?.questions.remove(question);
    var result =await FirebaseFun
        .updateLesson(lesson: lesson!,);
    Get.back();
    if(result['status']){
      Get.back();
      ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast('تمت حذف السؤال بنجاح'),state: result['status']);
    }else{
      lesson?.questions.add(question);
      ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    }
    return result;
  }
  updateLesson(List<LessonModel> lessons){
    for(LessonModel lessonModel in lessons){
      if(lesson?.id==lessonModel.id)
        lesson=lessonModel;
    }
  }








  @override
  void dispose() {
    super.dispose();
  }


}
