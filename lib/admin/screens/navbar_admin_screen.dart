import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
        child: Row(
          children: [
            CollapsingNavigationDrawer(),
            const SizedBox(width: AppSize.s20,),
            GetBuilder<AdminController>(
              init: AdminController(),
              builder: (adminController) {
                return Expanded(
                  child: controller.adminScreens[controller.currentIndex],
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
