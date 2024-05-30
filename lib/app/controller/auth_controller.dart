import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../core/utils/app_string.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();

  //controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();


  int currentIndex = 0;
  late final PageController pageController;
  final List<String> tabsList = [AppString.login, AppString.signup];

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
