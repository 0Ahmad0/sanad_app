import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanad_app/admin/screens/add_lesson_admin_screen.dart';
import 'package:sanad_app/admin/screens/add_questions_admin_screen.dart';
import 'package:sanad_app/admin/screens/educational_materials_management_admin_screens.dart';
import 'package:sanad_app/admin/screens/elderly_management_admin_screen.dart';
import 'package:sanad_app/admin/screens/home_admin_screen.dart';
import 'package:sanad_app/admin/screens/lesson_requests_admin_screen.dart';
import 'package:sanad_app/admin/screens/questions_manage_admin_screen.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';

class AdminController extends GetxController {
  int currentIndex = -1;
  List<Widget> adminScreens = [
    ElderlyManagementAdminScreen(),
    EducationalMaterialsManagementAdminScreen(),
    // AddLessonAdminScreen(),
    // AddQuestionsAdminScreen(),
    QuestionsManageAdminScreen(),
    LessonRequestsAdminScreen(),
  ];

  changePage(int index) {
    currentIndex = index;
    update();
  }

  late final ImagePicker picker;
  File? videoFile;
  File? audioFile;
  List<File> images = [];

  Future pickImages() async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        images.add(File(xfilePick[i].path));
      }
      update();
    } else {
      if(images.isEmpty)
      Get.snackbar('خطأ', 'لم تقم بتحديد أية صور',backgroundColor: ColorManager.errorColor,colorText: ColorManager.whiteColor);

    }
  }

  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      videoFile = File(pickedFile.path);
      update();
    } else {
      if(videoFile == null)
      Get.snackbar('خطأ', 'لم تقم بتحديد فيديو',backgroundColor: ColorManager.errorColor,colorText: ColorManager.whiteColor);

    }
  }

  Future<void> pickAudio() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      audioFile = File(result.files.single.path!);
      update();
    } else {
      if(audioFile == null)
      Get.snackbar('خطأ', 'لم تقم بتحديد صوت ',backgroundColor: ColorManager.errorColor,colorText: ColorManager.whiteColor);
    }
  }

  @override
  void onInit() {
    picker = ImagePicker();
    super.onInit();
  }
}
