

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanad_app/app/controller/profile_controller.dart';
import 'package:sanad_app/app/core/utils/app_constant.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/models/user_model.dart';

import '../../user/widgets/constants_widgets.dart';
import '../models/lesson_model.dart';
import '../widgets/constants_widgets.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';


class LessonController extends GetxController{

  late TextEditingController nameController ;
  late TextEditingController descriptionController ;
  int currentProgress=0;
  int fullProgress=0;
  String? uid;
  LessonModel? lesson;

  @override
  void onInit() {
    lesson=Get.arguments?['lesson'];
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;
    // uid= ProfileController.instance.currentUser.value?.uid;
    nameController=TextEditingController(text:lesson?.name );
    descriptionController=TextEditingController(text:lesson?.description );
    super.onInit();
    }


  addLesson(context,{ File? videoFile,File? audioFile,List<File> images = const[],String? status,bool withUserId=false}) async {
    _calculateProgress(videoFile, audioFile, images);
     Get.dialog(
      GetBuilder<LessonController>(
          builder: (LessonController controller) =>
              ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
      ),
      barrierDismissible: false,
    );

    String name=nameController.value.text;
     status=status??StatusLesson.accepted.name;
    String? videoPath;
    String? filePath;
    List<String> imagesPath=[];
    if(videoFile!=null){
      videoPath=await FirebaseFun.uploadImage(image: XFile(videoFile.path),folder: FirebaseConstants.collectionLesson+'/$name');
      _plusProgress();
    }
    if(audioFile!=null){
      filePath=await FirebaseFun.uploadImage(image: XFile(audioFile.path),folder: FirebaseConstants.collectionLesson+'/$name');
      _plusProgress();
    }
    for(File image in images){
      String? imagePath=await FirebaseFun.uploadImage(image: XFile(image.path),folder: FirebaseConstants.collectionLesson+'/$name');
     if(imagePath!=null)
       imagesPath.add(imagePath);
      _plusProgress();
    }

    LessonModel lessonModel=LessonModel(
      id: name+'${Timestamp.now().microsecondsSinceEpoch}',
      name: name,
      description: descriptionController.value.text,
      imagesPath: imagesPath,
      videoPath: videoPath,
      filePath: filePath,
      dateTime: DateTime.now(),
      status: status,
      idUser: withUserId?uid:null
    );

    var
    result=await FirebaseFun.addLesson(lesson:lessonModel);

    Get.back();
    if(result['status'])
      Get.back();
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }
  updateLesson(context,{ File? videoFile,File? audioFile,List<File> images = const[]}) async {
    _calculateProgress(videoFile, audioFile, images);
    Get.dialog(
      GetBuilder<LessonController>(
          builder: (LessonController controller) =>
              ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
      ),
      barrierDismissible: false,
    );

    String name=nameController.value.text;

    String? videoPath;
    String? filePath;
    List<String> imagesPath=[];
    if(videoFile!=null){
      videoPath=await FirebaseFun.uploadImage(image: XFile(videoFile.path),folder: FirebaseConstants.collectionLesson+'/$name');
      _plusProgress();
    }
    if(audioFile!=null){
      filePath=await FirebaseFun.uploadImage(image: XFile(audioFile.path),folder: FirebaseConstants.collectionLesson+'/$name');
      _plusProgress();
    }
    for(File image in images){
      String? imagePath=await FirebaseFun.uploadImage(image: XFile(image.path),folder: FirebaseConstants.collectionLesson+'/$name');
      if(imagePath!=null)
        imagesPath.add(imagePath);
      _plusProgress();
    }
    lesson?.name=name;
    lesson?.description= descriptionController.value.text;
    lesson?.imagesPath=imagesPath.isNotEmpty?imagesPath:lesson?.imagesPath??[];
    lesson?.videoPath=videoPath??lesson?.videoPath;
    lesson?.filePath=filePath??lesson?.filePath;

    var
    result=await FirebaseFun.updateLesson(lesson:lesson!);
    Get.back();
    if(result['status'])
      Get.back();
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }



  // updateClassRoom(context,{required ClassRoomModel classRoom}) async {
  //   ConstantsWidgets.showLoading();
  //   var
  //   result=await FirebaseFun.updateClassRoom(classRoom:classRoom);
  //   Get.back();
  //   ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
  //   return result;
  // }

  _calculateProgress(File? videoFile,File? audioFile,List<File> images){
    currentProgress=0;
    fullProgress=1;
    fullProgress+=videoFile==null?0:1;
    fullProgress+=audioFile==null?0:1;
    fullProgress+=images.length;
    update();
  }
  _plusProgress(){
    currentProgress++;
    if(currentProgress>fullProgress)
      currentProgress=fullProgress;
    update();
  }


  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }


}
