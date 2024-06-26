import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/assets_manager.dart';
import '../core/utils/values_manager.dart';

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
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        image: DecorationImage(
          repeat: ImageRepeat.repeatX,
            image: AssetImage(
              AssetsManager.backgroundButtonIMG,

            ),
            fit: BoxFit.cover),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r),
                side:  BorderSide(
                    color: ColorManager.borderButtonColor, width: 4)),
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
                fontFamily: GoogleFonts.cairo().fontFamily),
          )),
    );
  }
}
