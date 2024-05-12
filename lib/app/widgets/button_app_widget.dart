import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';

import '../core/utils/color_manager.dart';

class ButtonAppWidget extends StatelessWidget {
  const ButtonAppWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: ColorManager.secondaryColor.withOpacity(.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r),
              side: const BorderSide(color: ColorManager.secondaryColor, width: 5)),
          minimumSize: Size.fromHeight(
            AppSize.s60.sp,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: ColorManager.whiteColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.cairo().fontFamily
          ),
        ));
  }
}
