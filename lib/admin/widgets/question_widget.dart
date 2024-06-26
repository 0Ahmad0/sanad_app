import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/widgets/container_auth_widget.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: ContainerAuthWidget(
        child: Column(
          children: [
            ListTile(
              title: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: StylesManager.textNormalStyle(
                    color: ColorManager.primaryColor,
                    size: 12.sp
                ),
              ),
              subtitle: Text('السؤال يظهر هنا',style: StylesManager.textNormalStyle(
                size: 10.sp,
                color: ColorManager.secondaryColor
              ),),
            ),
            Row(
              children: [
                FittedBox(
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: CircleAvatar(
                          radius: 10.sp,
                          backgroundColor: ColorManager.secondaryColor,
                          child: Icon(
                            Icons.edit,
                            size: 14.sp,
                            color: ColorManager.whiteColor,
                          )),
                      label: Text(
                        AppString.edit,
                        style: StylesManager.textNormalStyle(
                            color: ColorManager.secondaryColor,
                            size: 10.sp
                        ),
                      )),
                ),
                FittedBox(
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: CircleAvatar(
                          radius: 10.sp,
                          backgroundColor: ColorManager.errorColor,
                          child: Icon(
                            Icons.delete,
                            size: 14.sp,
                            color: ColorManager.whiteColor,
                          )),
                      label: Text(
                        AppString.delete,
                        style: StylesManager.textNormalStyle(
                            color: ColorManager.secondaryColor,
                            size: 10.sp
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
