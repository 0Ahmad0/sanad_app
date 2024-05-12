import 'package:get/get.dart';
import 'package:sanad_app/app/screens/auth/auth_screen.dart';
import 'package:sanad_app/app/screens/splash_screen.dart';

class AppRoute {
  ///<Screens Names>///
  static const initialRoute = '/';
  static const authRoute = '/auth';

  static List<GetPage> appPages = [
    GetPage(
      name: '/',
      page: () => const SplashScreen(),
      transition: Transition.zoom
    ),
    GetPage(
      name: '/auth',
      page: () => const AuthScreen(),
      transition: Transition.leftToRightWithFade
    ),
  ];
}
