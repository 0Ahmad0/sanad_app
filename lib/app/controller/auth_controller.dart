import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/controller/firebase/firebase_constants.dart';
import 'package:sanad_app/app/controller/firebase/firebase_fun.dart';
import 'package:sanad_app/app/controller/profile_controller.dart';
import 'package:sanad_app/app/models/user_model.dart';
import 'package:sanad_app/app/screens/auth/auth_screen.dart';
import 'package:sanad_app/app/screens/splash_screen.dart';
import '../../admin/screens/navbar_admin_screen.dart';
import '../../user/screens/navbar_user_screen.dart';
import '../../user/widgets/constants_widgets.dart';
import '../core/local/storage.dart';
import '../core/utils/app_constant.dart';
import '../core/utils/app_string.dart';
import '../core/utils/color_manager.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  static AuthController  get instance => Get.find();
  //controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();


  int currentIndex = 0;
  late final PageController pageController;
  final List<String> tabsList = [AppString.login, AppString.signup];

  final FirebaseAuth auth = FirebaseAuth.instance;

  _initPageView() {
    pageController = PageController(initialPage: 0);
  }

  navigateToPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut
    );
    currentIndex = index;
    update();
  }

  String? validatePassword(String value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return AppString.requiredFiled;
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return AppString.requiredFiled;
    } else {
      if (!value.isPhoneNumber) {
        return 'خطأ';
      } else {
        return null;
      }
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return AppString.requiredFiled;
    } else {
      if (!value.isEmail) {
        return 'خطأ';
      } else {
        return null;
      }
    }
  }

  String? validateFullName(String value) {
    if (value.isEmpty) {
      return AppString.requiredFiled;
    }
    return null;
  }

  Future<void> login() async {
    String userName=emailController.value.text;
    String password=passwordController.value.text;
    String email=userName;
    try {
      ConstantsWidgets.showLoading();
      var result=await FirebaseFun.fetchUserByUserName(userName: userName);
      ///handling
      // !result['status']?throw FirebaseAuthException(code: result['message']):'';
     print(result);
      if(result['status']&&result['body']!=null){
       UserModel? userModel=UserModel.fromJson(result['body']);
       // if(userModel==null)
       //   throw FirebaseAuthException(code: AppString.message_user_name_invalid);
       email=userModel?.email??userName;
     }

      //,,,,,,,,,,,,,,,,,
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(FirebaseFun.timeOut)
          .then((value) async {
        Get.snackbar(
            AppString.message_success,
            AppString.message_successful_login,
            backgroundColor: ColorManager.successColor
        );

         AppStorage.storageWrite(key:AppConstants.rememberMe,value:  true);
         AppStorage.storageWrite(key:AppConstants.uidKEY, value: auth.currentUser?.uid);
         AppStorage.storageWrite(key:AppConstants.EMAIL_KEY,value:  email);
         AppStorage.storageWrite(key:AppConstants.PASSWORD_KEY,value:  password);


          //Get.offAll(HomePage());
        ProfileController profileController=Get.put(ProfileController());;
        await profileController.getUser();

        Get.back();
        if(profileController.currentUser.value?.isAdmin??false)
          Get.offAll(NavBarAdminScreen());
        else
          Get.offAll(NavbarUserScreen());



      });
    } on FirebaseAuthException catch (e) {
      String errorMessage=FirebaseFun.findTextToast(e.code);
      Get.back();
      Get.snackbar(
          AppString.message_failure,
         errorMessage,
          backgroundColor: ColorManager.errorColor
      );
    }
  }

  Future<void> signUp() async {
    String name=nameController.value.text;
    String email=emailController.value.text;
    String phoneNumber=phoneController.value.text;
    String password=passwordController.value.text;

    // String name='Ahmad Mriwed';
    // String email='mr.ahmadmriwed@gmail.com';
    // String phoneNumber='0937954969';
    // String password='12345678';
    try {
      ConstantsWidgets.showLoading();
      String userName=await _getUserNameByName(name);
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password).timeout(FirebaseFun.timeOut);
      final user = UserModel(
          uid: userCredential.user!.uid,
          email: email,
          name: name,
          phoneNumber:phoneNumber,
          userName: userName,
          password: password,
          typeUser: AppConstants.collectionUser,
          photoUrl: ''
      );
      await FirebaseFirestore.instance
          .collection(FirebaseConstants.collectionUser)
          .doc(user.uid)
          .set(user.toJson());
      await AppStorage.storageWrite(key:AppConstants.rememberMe,value:  true);
      await AppStorage.storageWrite(key:AppConstants.uidKEY,value:  user.uid);

      // ProfileController.instance.getUser();

      ProfileController profileController=Get.put(ProfileController());
      if(profileController.currentUser.value?.isAdmin??false)
        Get.offAll(NavBarAdminScreen());
      else
        Get.offAll(NavbarUserScreen());

    } on FirebaseAuthException catch (e) {
      String errorMessage=FirebaseFun.findTextToast(e.code);
      Get.back();
      Get.snackbar(
          AppString.message_failure,
          errorMessage,
          backgroundColor: ColorManager.errorColor
      );
    }
  }

  _generateUserNameByName(String name){
    name=name.toLowerCase();
      List<String> names = name.split(' ');
      String firstName= names.isNotEmpty ? names.first : '';
      String? lastName= names.length > 1 ? names.sublist(1).join(' ') : null;
      String userName='${firstName}';
      if(lastName!=null)
        userName+='_${lastName}';
    return userName;
  }
  _getUserNameByName(String name) async {
    String genUserName=_generateUserNameByName(name);
    String userName=genUserName;
    var result=await FirebaseFun.fetchUsers();
    if(!result['status']) return null;
    Users users=Users.fromJson(result['body']);
    for(int i=0;i<10000;i++){
      bool exists = users.users.any((user) => user.userName == userName);
      if(exists)
        userName=genUserName+'$i';
        else
          break;
    }
    return userName;

  }


  void signOut({bool deleteFromAuth = false}) async {
    await auth.signOut().then((value) async {
      if(deleteFromAuth){
        auth.currentUser?.delete();
      }
     await AppStorage.storageDelete(key:AppConstants.rememberMe);
      AppStorage.storageDelete(key:AppConstants.uidKEY);
      AppStorage.storageDelete(key:AppConstants.EMAIL_KEY);
      AppStorage.storageDelete(key:AppConstants.PASSWORD_KEY);
      AppStorage.storageDelete(key:AppConstants.USER_NAME_KEY);
    });
    Get.offAll(SplashScreen());
  }

@override
void onInit() {
  _initPageView();
  super.onInit();
}

@override
void onClose() {
  nameController.dispose();
  emailController.dispose();
  phoneController.dispose();
  passwordController.dispose();
  pageController.dispose();
  super.onClose();
}

}
