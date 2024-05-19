import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanad_app/admin/screens/home_admin_screen.dart';
import 'package:sanad_app/app/controller/admin_controller.dart';
import 'package:sanad_app/app/core/helper/sizer_media_query.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

import '../widgets/collapsing_drawer_widget.dart';

class NavBarAdminScreen extends StatelessWidget {
  const NavBarAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());
    print(controller.currentIndex);
    return Scaffold(
      body: DefaultScaffoldWidget(
        child: Stack(
          children: [
            GetBuilder<AdminController>(
                init: AdminController(),
                builder: (adminController) {
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(right: AppPadding.p90),
                      child: adminController.currentIndex == -1
                          ? HomeScreenAdmin()
                          : adminController
                              .adminScreens[adminController.currentIndex],
                    ),
                  );
                }),
            CollapsingNavigationDrawer(),
            GetBuilder<AdminController>(
                init: AdminController(),
                builder: (adminController) {
                  return Positioned(
                    left: 0,
                    top: AppSize.s30,
                    child: IconButton(
                        onPressed: () {
                          adminController.changePage(-1);
                        },
                        icon: CircleAvatar(
                            backgroundColor: ColorManager.primaryColor,
                            child: Icon(
                              Icons.home_filled,
                              color: ColorManager.whiteColor,
                            ))),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
