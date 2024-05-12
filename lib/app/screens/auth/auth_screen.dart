import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/helper/sizer_media_query.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
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
                    border:
                        Border.all(color: ColorManager.secondaryColor, width: 3)),
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: ColorManager.primaryColor,
                )),
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
      ),
      body: DefaultScaffoldWidget(),
    );
  }
}
