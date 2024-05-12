import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '/app/core/helper/convert_to_material_color.dart';
import 'color_manager.dart';

class ThemeManager {
  static ThemeData myTheme = ThemeData(
          fontFamily: GoogleFonts.cairo().fontFamily,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
              ColorScheme.fromSeed(seedColor: ColorManager.primaryColor),
          useMaterial3: true,
          primarySwatch: Color(
            ColorManager.primaryColor.value,
          ).toMaterialColor(),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: ColorManager.secondaryColor,
            foregroundColor: ColorManager.primaryColor,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: ColorManager.appBarColor,
            iconTheme: const IconThemeData(
              color: ColorManager.whiteColor,
            ),
            centerTitle: true,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorManager.whiteColor,
                fontSize: 24.sp),
          ),
          drawerTheme:
              const DrawerThemeData(backgroundColor: ColorManager.secondaryColor))
      .copyWith(
    textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
  );
}
