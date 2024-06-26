

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../user/widgets/dialog_widget.dart';

import '../models/lesson_model.dart';
import '../widgets/constants_widgets.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';


class LessonsController extends GetxController{

  final searchController = TextEditingController();
  LessonsModel lessons=LessonsModel(items: []);
  LessonsModel lessonsWithFilter=LessonsModel(items: []);
  var getLessons;
  @override
  void onInit() {
    searchController.clear();
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

  deleteLesson(context,{required String? idLesson}) async{
    var result;
     Get.dialog(DialogWidget(
         title: 'حذف الدرس',
     text: 'هل أنت متأكد أنك تريد حذف الدرس؟',
         onPressed:() async {
           Get.back();
           ConstantsWidgets.showLoading();
           result=await FirebaseFun
               .deleteLesson(idLesson: idLesson??'',);
           Get.back();
           ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);

           update();
         }
     ));

    return result;

  }
  _fetchLessonsStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionLesson)
        .where('status',isEqualTo: StatusLesson.accepted.name)
        .snapshots();
    return result;

  }
  filterLessons({required String term}) async {
    lessonsWithFilter.items=[];
    lessons.items.forEach((element) {

      if((element.name?.toLowerCase().contains(term.toLowerCase())??false))
        lessonsWithFilter.items.add(element);
    });
     update();
  }

}
