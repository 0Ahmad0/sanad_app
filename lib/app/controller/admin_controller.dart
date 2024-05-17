import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanad_app/admin/screens/add_lesson_screen.dart';
import 'package:sanad_app/admin/screens/add_questions_screen.dart';
import 'package:sanad_app/admin/screens/educational_materials_management_screens.dart';
import 'package:sanad_app/admin/screens/elderly_management_screen.dart';
import 'package:sanad_app/admin/screens/home_admin_screen.dart';
import 'package:sanad_app/admin/screens/lesson_requests_screen.dart';
import 'package:sanad_app/admin/screens/questions_manage_screen.dart';

class AdminController extends GetxController {
  int currentIndex = 0;
  List<Widget> adminScreens = [
    HomeScreenAdmin(),
    AddLessonScreen(),
    AddQuestionsScreen(),
    EducationalMaterialsManagementScreen(),
    ElderlyManagementScreen(),
    LessonRequestsScreen(),
    QuestionsManageScreen(),
  ];
}
