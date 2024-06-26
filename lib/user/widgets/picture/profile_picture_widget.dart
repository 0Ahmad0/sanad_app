
import 'package:flutter/material.dart';

import '../../../app/core/utils/color_manager.dart';
import '../../../app/core/utils/values_manager.dart';



class WidgetProfilePicture extends StatelessWidget {
  Color textColor;
  Color backgroundColor;
  final String name;
  final String? role;
  final double radius;
  final double fontSize;
  WidgetProfilePicture({
    this.textColor = Colors.white,
    this.backgroundColor = ColorManager.primaryColor,
     required this.name,
    this.role,
     required this.radius,
      this.fontSize = AppSize.s18,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        //borderRadius: BorderRadius.circular(radius)
      ),
      
      child:
          Text(
            '${findFirstsCharFromText(name)}',
            style: TextStyle(
              fontSize: fontSize,
              color: textColor
            ),),
    );
  }
  String findFirstsCharFromText(String text){

    String firstsCharFromText="";
    List<String> listFromWord=text.trim().split(" ");
    firstsCharFromText+=listFromWord.first.characters.first.toUpperCase();
    (listFromWord.length>1)?firstsCharFromText+=listFromWord.last[0]:"";
    return firstsCharFromText;
  }
}