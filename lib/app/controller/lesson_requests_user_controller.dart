

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/controller/profile_controller.dart';
import 'package:sanad_app/app/core/utils/app_constant.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/models/user_model.dart';

import '../../user/widgets/constants_widgets.dart';
import '../models/lesson_model.dart';
import '../widgets/constants_widgets.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';


class LessonsRequestsUserController extends GetxController{

  final searchController = TextEditingController();
  LessonsModel lessons=LessonsModel(items: []);
  LessonsModel lessonsWithFilter=LessonsModel(items: []);
  String? uid;
  var getLessons;
  @override
  void onInit() {
    searchController.clear();
    ProfileController profileController=Get.put(ProfileController());
    // uid= ProfileController.instance.currentUser.value?.uid;
    uid= profileController.currentUser.value?.uid;
    getLessonsFun();

    super.onInit();
    }

  getLessonsFun() async {
    getLessons =_fetchLessonsStream();
    return getLessons;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  ChangeStatus(context,{required LessonModel lesson,required StatusLesson status}) async{
    lesson.status=status.name;
    var result =await FirebaseFun
        .updateLesson(lesson: lesson,);
    String message=result['status']?'تم ${status.name} الطلب':result['message'].toString();
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(message),state: result['status']);
    update();
    return result;
  }
  _fetchLessonsStream() {

    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionLesson)
        .where('idUser',isEqualTo: uid)
        .snapshots();
    return result;

  }
  filterLessons({required String term}) async {
    lessonsWithFilter.items=[];
    lessons.items.forEach((element) {

      if((element.name?.toLowerCase().contains(term.toLowerCase())??false)
      ||(element.status?.toLowerCase().contains(term.toLowerCase())??false))
        lessonsWithFilter.items.add(element);
    });
     update();
  }

}
