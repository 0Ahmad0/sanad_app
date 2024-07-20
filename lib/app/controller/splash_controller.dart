
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'profile_controller.dart';
import '../core/utils/app_constant.dart';

import '../../admin/screens/navbar_admin_screen.dart';
import '../../user/screens/navbar_user_screen.dart';
import '../core/local/storage.dart';
import '../widgets/constants_widgets.dart';

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

      ProfileController profileController=Get.put(ProfileController());

      await profileController.getUser();
      // await ProfileController.instance.getUser();
      if(profileController.currentUser.value?.isAdmin??false)
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
