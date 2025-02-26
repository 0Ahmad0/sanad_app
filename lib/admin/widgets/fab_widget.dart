
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../app/controller/fab_controller.dart';
import '../../app/core/utils/color_manager.dart';



class FabWidget extends StatelessWidget {
  const FabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final fabController=Get.put(FabController());
    return FloatingActionButton(
        backgroundColor: ColorManager.primaryColor,
        child: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          showMenu(
            context: context,
            position:  RelativeRect.fromLTRB(100, 80.h, 100, 0),
            items: [
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  // title: const Text('Login as user'),
                  title: const Text('تسجيل الدخول كطالب'),
                  onTap: () {
                    Navigator.pop(context);
                    fabController.loginAsUser(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.admin_panel_settings),
                  // title: const Text('Login as Admin'),
                  title: const Text('تسجيل الدخول كمدير'),
                  onTap: () {
                    Navigator.pop(context);
                    fabController.loginAsAdmin(context);
                  },
                ),
              ),
              // PopupMenuItem(
              //   child: ListTile(
              //     leading: const Icon(Icons.manage_accounts),
              //     title: const Text('Login as default worker'),
              //     // title: const Text('تسجيل الدخول كمدير'),
              //     onTap: () {
              //       Navigator.pop(context);
              //       fabController.loginAsWorker(context);
              //     },
              //   ),
              // ),

              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.settings_backup_restore),
                  // title: const Text('Restore default data'),
                  title: const Text('استعادة البيانات الافتراضية'),
                  onTap: () async {
                    Navigator.pop(context);

                    fabController.restoreData(context);
                    // context.pushNamed('/settings');
                  },
                ),
              ),
              // PopupMenuItem(
              //   child: ListTile(
              //     leading: const Icon(Icons.info),
              //     title: const Text('حول التطبيق'),
              //     onTap: () {
              //       Navigator.pop(context);
              //       context.pushNamed('/about');
              //     },
              //   ),
              // ),
            ],
          );});
  }
}
