import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/controller/admin_controller.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/widgets/default_scaffold.dart';
import '../widgets/collapsing_drawer_widget.dart';
import 'home_admin_screen.dart';

class NavBarAdminScreen extends StatefulWidget {
  const NavBarAdminScreen({super.key});

  @override
  State<NavBarAdminScreen> createState() => _NavBarAdminScreenState();
}

class _NavBarAdminScreenState extends State<NavBarAdminScreen> {
  @override
  void initState() {
    // Get.lazyPut(() => ProfileController());
    // ProfileController.instance.getUser();
    // ProfileController profileController=Get.put(ProfileController());
    //  profileController.getUser();
    super.initState();
  }
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
                          ? HomeAdminScreen()
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
