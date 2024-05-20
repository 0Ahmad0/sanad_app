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
  File? video;
  File? audioFile;
  List<File> images = [];

  // Future<void> _pickImages() async {
  //   List<File> pickedFiles = await ImagePickerExtended().pickMultiImage();
  //
  //   if (pickedFiles.isNotEmpty) {
  //     setState(() {
  //       _images = pickedFiles;
  //     });
  //   }
  // }
  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      video = File(pickedFile.path);
      update();
    }
  }


  Future<void> pickAudio() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
        audioFile = File(result.files.single.path!);
    }
  }

  @override
  void onInit() {
    picker = ImagePicker();
    super.onInit();
  }
}
