import 'package:get/get.dart';
import 'package:sanad_app/admin/screens/navbar_admin_screen.dart';
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
  static const homeAdminRoute = '/homeAdmin';

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
      name: homeAdminRoute,
      page: () => NavBarAdminScreen(),
      transition: Transition.fadeIn,
    )
  ];
}
