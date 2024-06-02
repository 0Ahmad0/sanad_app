import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sanad_app/app/controller/auth_controller.dart';
import 'package:sanad_app/app/controller/profile_controller.dart';
import 'package:sanad_app/app/core/utils/app_constant.dart';

import '../../admin/screens/navbar_admin_screen.dart';
import '../../user/screens/navbar_user_screen.dart';
import '../../user/widgets/constants_widgets.dart';
import '../core/local/storage.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin   {
  // static SplashController  get instance => Get.find();
   int delaySplash=1;

  
  @override
  Future<void> onInit() async {
    await initSplash();
    super.onInit();
  }

  Future<void> _loadSplash()  async {
    await Future.delayed( Duration(seconds: delaySplash), () {
      // Get.offAll(page);
    });

    if((await AppStorage.storageRead(key: AppConstants.rememberMe) as bool?) ??false){
      ConstantsWidgets.showLoading();
      await ProfileController.instance.getUser();
      if(ProfileController.instance.currentUser.value?.isAdmin??false)
        Get.offAll(NavBarAdminScreen());
      else
        Get.offAll(NavbarUserScreen());
    }
  }
  Future<void> _initSplash() async {
    await AppStorage.init();
    // Get.put(ProfileController());
    // Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => AuthController());
  }
  Future<void> initSplash() async {
    await _initSplash();
    await _loadSplash();
  }

}
