import 'package:get/get.dart';
import 'package:sanad_app/admin/screens/show_media_lessons_screen.dart';
import '../../../admin/screens/add_lesson_admin_screen.dart';
import '../../../admin/screens/add_questions_admin_screen.dart';
import '../../../admin/screens/educational_materials_management_admin_screens.dart';
import '../../../admin/screens/elderly_management_admin_screen.dart';
import '../../../admin/screens/home_admin_screen.dart';
import '../../../admin/screens/lesson_requests_admin_screen.dart';
import '../../../admin/screens/navbar_admin_screen.dart';
import '../../../admin/screens/questions_manage_admin_screen.dart';
import '../../../admin/screens/show_user_profile_screen.dart';
import '../../screens/auth/auth_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/splash_screen.dart';
import '../../../user/screens/add_lesson_user_screen.dart';
import '../../../user/screens/home_user_screen.dart';
import '../../../user/screens/lessons_user_screen.dart';
import '../../../user/screens/managing_lesson_user_screens.dart';
import '../../../user/screens/navbar_user_screen.dart';
import '../../../user/screens/questions_user_screen.dart';
import '../../../user/screens/rate_lesson_screen.dart';
import '../../../user/screens/show_audio_screen.dart';
import '../../../user/screens/show_question_user_screen.dart';
import '../../../user/screens/show_vedio_screen.dart';

import '../../../user/screens/show_text_screen.dart';
import '../../screens/auth/forget_password_screen.dart';

class AppRoute {
  ///<Screens Names>///
  static const initialRoute = '/';
  static const authRoute = '/auth';
  static const forgetPasswordRoute = '/forgetPassword';
  static const profileRoute = '/profile';

  ///Admin Screens
  static const navBarAdminRoute = '/navBarAdmin';
  static const addLessonAdminRoute = '/addLessonAdmin';
  static const addQuestionsAdminRoute = '/addQuestionsAdmin';
  static const showMediaLessonsRoute = '/showMediaLessons';
  static const educationalMaterialsManagementAdminRoute =
      '/educationalMaterialsManagementAdmin';
  static const elderlyManagementAdminRoute = '/elderlyManagementRouteAdmin';
  static const homeAdminRoute = '/homeAdmin';
  static const lessonRequestsAdminRoute = '/lessonRequestsAdmin';
  static const questionsManageAdminRoute = '/questionsManageAdmin';
  static const ShowUserProfileAdminRoute = '/ShowUserProfileAdmin';

  ///User Screens
  static const navBarRoute = '/nabBar';
  static const homeUserRoute = '/homeUser';
  static const lessonsUserRoute = '/lessonsUser';
  static const rateLessonUserRoute = '/rateLessonUser';
  static const questionUserRoute = '/questionUser';
  static const showQuestionUserRoute = '/showQuestionUser';
  static const managingLessonUserRoute = '/managingLessonUser';
  static const addLessonUserRoute = '/addLessonUser';
  static const showAudioUserRoute = '/showAudioUser';
  static const showVedioUserRoute = '/showVedioUser';
  static const showTextUserRoute = '/showTextUser';

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
      name: profileRoute,
      page: () =>  ProfileScreen(),
      transition: Transition.fadeIn,
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
    GetPage(
      name: navBarRoute,
      page: () => NavbarUserScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: homeUserRoute,
      page: () => HomeUserScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: lessonsUserRoute,
      page: () => LessonUserScreen(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: rateLessonUserRoute,
      page: () => RateLessonScreen(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name: questionUserRoute,
      page: () => QuestionsUserScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: showQuestionUserRoute,
      fullscreenDialog:true,
      page: () => ShowQuestionUserScreen(),
      transition: Transition.downToUp,
    ), GetPage(
      name: managingLessonUserRoute,
      page: () => ManagingLessonUserScreen(),
      transition: Transition.cupertinoDialog,
    ),
    GetPage(
      name:addLessonUserRoute,
      page: () => AddLessonUserScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name:showAudioUserRoute,
      page: () => ShowAudioScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name:showVedioUserRoute,
      page: () => ShowVedioScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name:showTextUserRoute,
      page: () => ShowTextScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name:showMediaLessonsRoute,
      page: () => ShowMediaLessonsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name:ShowUserProfileAdminRoute,
      page: () => ShowUserProfileScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
