import 'package:get/get.dart';
import 'package:sanad_app/admin/screens/add_lesson_admin_screen.dart';
import 'package:sanad_app/admin/screens/add_questions_admin_screen.dart';
import 'package:sanad_app/admin/screens/educational_materials_management_admin_screens.dart';
import 'package:sanad_app/admin/screens/elderly_management_admin_screen.dart';
import 'package:sanad_app/admin/screens/home_admin_screen.dart';
import 'package:sanad_app/admin/screens/lesson_requests_admin_screen.dart';
import 'package:sanad_app/admin/screens/navbar_admin_screen.dart';
import 'package:sanad_app/admin/screens/questions_manage_admin_screen.dart';
import 'package:sanad_app/app/controller/auth_controller.dart';
import 'package:sanad_app/app/screens/auth/auth_screen.dart';
import 'package:sanad_app/app/screens/splash_screen.dart';

import '../../screens/auth/forget_password_screen.dart';

class AppRoute {
  ///<Screens Names>///
  static const initialRoute = '/';
  static const authRoute = '/auth';
  static const forgetPasswordRoute = '/forgetPassword';
  ///Admin Screens
  static const navBarAdminRoute = '/navBarAdmin';
  static const addLessonAdminRoute = '/addLessonAdmin';
  static const addQuestionsAdminRoute = '/addQuestionsAdmin';
  static const educationalMaterialsManagementAdminRoute = '/educationalMaterialsManagementAdmin';
  static const elderlyManagementAdminRoute = '/elderlyManagementRouteAdmin';
  static const homeAdminRoute = '/homeAdmin';
  static const lessonRequestsAdminRoute = '/lessonRequestsAdmin';
  static const questionsManageAdminRoute = '/questionsManageAdmin';

  static List<GetPage> appPages = [
    GetPage(
        name: initialRoute,
        page: () => const SplashScreen(),
        transition: Transition.zoom),
    GetPage(
        name: authRoute,
        page: () => const AuthScreen(),
        transition: Transition.leftToRightWithFade,
       ),
    GetPage(
      name: forgetPasswordRoute,
      page: () => ForgetPasswordScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: navBarAdminRoute,
      page: () => NavBarAdminScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: homeAdminRoute,
      page: () => HomeAdminScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: addLessonAdminRoute,
      page: () => AddLessonAdminScreen(),
      transition: Transition.size,
    ),
    GetPage(
      name: addQuestionsAdminRoute,
      page: () => AddQuestionsAdminScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: educationalMaterialsManagementAdminRoute,
      page: () => EducationalMaterialsManagementAdminScreen(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: elderlyManagementAdminRoute,
      page: () => ElderlyManagementAdminScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: lessonRequestsAdminRoute,
      page: () => LessonRequestsAdminScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: questionsManageAdminRoute,
      page: () => QuestionsManageAdminScreen(),
      transition: Transition.topLevel,
    ),
  ];
}
