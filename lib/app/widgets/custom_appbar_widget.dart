import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/helper/sizer_media_query.dart';
import '../core/utils/assets_manager.dart';
import '../core/utils/color_manager.dart';
import '../core/utils/values_manager.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final List<Widget>? child;
  final double height;
  final bool showBackButton;

  const CustomAppBarWidget({
    super.key,
    this.child,
    this.height = 100,
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Visibility(
          visible: showBackButton,
          child: GestureDetector(
            onTap: () {
              if (Navigator.canPop(context)) {
                Get.back();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.secondaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                          color: ColorManager.secondaryColor, width: 3)),
                  child: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: ColorManager.primaryColor,
                  )),
            ),
          ),
        ),
        elevation: 8.0,
        shadowColor: ColorManager.blackColor.withOpacity(.25),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: getWidth(context) / 2.75),
                height: AppSize.s10,
                decoration: BoxDecoration(
                    color: ColorManager.greyColor,
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(100.r))),
              ),
              Container(
                margin: EdgeInsets.only(left: getWidth(context) / 4),
                height: AppSize.s10,
                decoration: BoxDecoration(
                    color: ColorManager.primaryColor.withOpacity(.5),
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(100.r))),
              ),
            ],
          ),
        ),
        flexibleSpace: Image.asset(
          AssetsManager.backgroundAppIMG,
          fit: BoxFit.fitWidth,
        ),
        title: Image.asset(
          AssetsManager.logoIMG,
          width: 200,
          height: 200,
        ),
        actions: child);
  }
}
