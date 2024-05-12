import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/route/app_route.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/widgets/button_app_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultScaffoldWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZoomIn(
                delay: const Duration(milliseconds: 750),
                child: Image.asset(AssetsManager.logoIMG)),
            SizedBox(
              height: AppSize.s10.sp,
            ),
            FadeInUp(
              delay: const Duration(milliseconds: 1000),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p40
                ),
                child: ButtonAppWidget(onPressed: () {
                  Get.toNamed(AppRoute.authRoute);
                }, text: AppString.letsGo),
              ),
            )
          ],
        ),
      ),
    );
  }
}
