import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_manager.dart';

class StylesManager {
  static TextStyle? textBoldStyle({
    color = ColorManager.whiteColor,
    double size = 18,
  }) {
    return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size.sp,
        color: color,
        fontFamily: GoogleFonts.cairo().fontFamily);
  }

  static TextStyle? textNormalStyle({
    color = ColorManager.whiteColor,
    double size = 14,
  }) {
    return TextStyle(
        fontSize: size.sp,
        color: color,
        fontFamily: GoogleFonts.cairo().fontFamily);
  }

//
}
