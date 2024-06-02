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
import 'package:sanad_app/app/controller/auth_controller.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/screens/profile_screen.dart';
import 'package:sanad_app/user/widgets/dialog_widget.dart';

import '../../admin/screens/add_question_screen.dart';
import '../models/question_model.dart';

class AdminController extends GetxController {
  int currentIndex = -1;
  List<Widget> adminScreens = [
    ElderlyManagementAdminScreen(),
    EducationalMaterialsManagementAdminScreen(),
    // AddLessonAdminScreen(),
    // AddQuestionsAdminScreen(),
    QuestionsManageAdminScreen(),
    LessonRequestsAdminScreen(),
    //
    SizedBox(),
    SizedBox(),
  ];

  changePage(int index) {
    if (index == 4) {
      Get.to(() => ProfileScreen());
    }
    if (index == 5) {
      Get.dialog(DialogWidget(onPressed: () {
        Get.lazyPut(()=>AuthController());
        AuthController.instance.signOut();
      },
        text: 'النص هنا',
        title: 'هل أنت متأكد من تسجيل خروجك؟',)
      );
    }
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
      if (images.isEmpty)
        Get.snackbar('خطأ', 'لم تقم بتحديد أية صور',
            backgroundColor: ColorManager.errorColor,
            colorText: ColorManager.whiteColor);
    }
  }

  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      videoFile = File(pickedFile.path);
      update();
    } else {
      if (videoFile == null)
        Get.snackbar('خطأ', 'لم تقم بتحديد فيديو',
            backgroundColor: ColorManager.errorColor,
            colorText: ColorManager.whiteColor);
    }
  }

  Future<void> pickAudio() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null) {
      audioFile = File(result.files.single.path!);
      update();
    } else {
      if (audioFile == null)
        Get.snackbar('خطأ', 'لم تقم بتحديد صوت ',
            backgroundColor: ColorManager.errorColor,
            colorText: ColorManager.whiteColor);
    }
  }

  List<Question> questions = [];

  void addQuestion(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            AddQuestionPage(
              onSave: (question) {
                questions.add(question);
                update();
              },
            ),
      ),
    );
  }

  @override
  void onInit() {
    picker = ImagePicker();
    super.onInit();
  }
}
