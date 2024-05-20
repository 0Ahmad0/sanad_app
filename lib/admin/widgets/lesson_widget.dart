import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/widgets/container_auth_widget.dart';

class LessonWidget extends StatelessWidget {
  const LessonWidget({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: ContainerAuthWidget(
        child: Row(
          children: [
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: StylesManager.textNormalStyle(
                  color: ColorManager.primaryColor,
                  size: 12.sp
              ),
            ),
            Text(' | '),
          ],
        ),
      ),
    );
  }
}
