import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/controller/profile_controller.dart';
import 'app/core/route/app_route.dart';
import 'app/core/utils/app_constant.dart';
import 'app/core/utils/app_string.dart';

AudioPlayer audio = AudioPlayer();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return ScreenUtilInit(
        designSize: Size(AppConstants.designWidth, AppConstants.designHeight),
        builder: (context, _) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar'),
            ],
            locale: const Locale('ar'),
            title: AppString.appName,
            // theme:ThemeManager.myTheme,
            theme: ThemeData(
                fontFamily: GoogleFonts.cairo().fontFamily,
),
            defaultTransition: Transition.fade,
            getPages: AppRoute.appPages,
          );
        });
  }
}
