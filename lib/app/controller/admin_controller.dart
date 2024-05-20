import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  changePage(int index){
    currentIndex = index;
    update();

  }
}
