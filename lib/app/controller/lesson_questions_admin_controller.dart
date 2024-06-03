

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanad_app/app/core/utils/app_constant.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/models/question_model.dart';
import 'package:sanad_app/app/models/user_model.dart';

import '../../user/widgets/constants_widgets.dart';
import '../models/lesson_model.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';


class LessonQuestionsController extends GetxController{

  LessonModel? lesson=Get.arguments?['lesson'];

  refreshQuestion(){
    lesson=Get.arguments?['lesson'];
  }

  @override
  void onInit() {
    lesson=Get.arguments?['lesson'];
    super.onInit();
    }


  addQuestion(BuildContext context,{required Question question}) async {
    ConstantsWidgets.showLoading();
    lesson?.questions.add(question);
    var result =await FirebaseFun
        .updateLesson(lesson: lesson!,);
    Get.back();
    if(result['status']){
      Get.back();
      ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast('تمت إضافة السؤال بنجاح'),state: result['status']);
    }else{
      lesson?.questions.removeLast();
      ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    }
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
