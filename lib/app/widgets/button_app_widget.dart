import 'package:flutter/material.dart';

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
          backgroundColor: ColorManager.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          minimumSize: Size.fromHeight(50),
        ),
        onPressed: onPressed,
        child: Text(text,style: TextStyle(
          color: ColorManager.whiteColor
        ),));
  }
}
