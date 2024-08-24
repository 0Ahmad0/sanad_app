import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'firebase/firebase_fun.dart';

import '../core/utils/app_string.dart';
import '../core/utils/color_manager.dart';
import '../widgets/constants_widgets.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  DateTime? dateTime;
  final emailController = TextEditingController();
  int countMinutes=5;

  late Timer timerCountDown;
  refreshTime(){
    print('start');
    timerCountDown = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      Duration difference = now.difference(dateTime??DateTime.now().add(Duration(minutes: countMinutes)));
      if(difference.inMinutes<countMinutes){
        update();
      }else{
        timer.cancel();
      }
    });
  }
  @override
  void onInit() {
     Future.delayed( Duration(seconds: 1), () {
     update();
    });
    super.onInit();
  }
  @override
  void onClose() {
   timerCountDown.cancel();
    emailController.dispose();
    super.onClose();
  }

  Future<bool?> send() async {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime??DateTime.now().add(Duration(minutes: countMinutes)));
    
    ConstantsWidgets.showLoading();
    try{

      if(difference.inMinutes.abs()<countMinutes)
        throw FirebaseAuthException(code: 'لا يمكنك اعادة ارسال الرمز حتى انتهاء المدة');
     await FirebaseFun.auth.sendPasswordResetEmail(email: emailController.value.text)
          .timeout(FirebaseFun.timeOut);
     Get.back();
     dateTime=DateTime.now();
      refreshTime();
     return true;

    } on FirebaseAuthException catch (e) {
      String errorMessage=FirebaseFun.findTextToast(e.code);
      Get.back();
      Get.snackbar(
          AppString.message_failure,
          errorMessage,
          backgroundColor: ColorManager.errorColor
      );
    }
    return null;
  }


  String getTimeDifference() {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime??DateTime.now().add(Duration(minutes: countMinutes)));

    if (difference.inMinutes >= countMinutes) {
      return '00:00';
    } else {
      int remainingSeconds = countMinutes * 60 - difference.inSeconds;
      int minutes = remainingSeconds ~/ 60;
      int seconds = remainingSeconds % 60;
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }
}
