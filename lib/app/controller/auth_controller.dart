import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/utils/app_string.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  int currentIndex = 0;
  late final PageController pageController;
  final List<String> tabsList = [AppString.login, AppString.signup];

  _initPageView() {
    pageController = PageController(initialPage: 0);
  }

  navigateToPage(int index){
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut
    );
    currentIndex = index;
    update();

  }

  @override
  void onInit() {
    _initPageView();
    super.onInit();
  }
}
