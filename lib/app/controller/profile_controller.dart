import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../core/utils/color_manager.dart';
import '../models/user_model.dart';
import '../widgets/constants_widgets.dart';
import 'firebase/firebase_fun.dart';

class ProfileController extends GetxController {
  late final ImagePicker _imagePicker;
  File? profileImage;
  final FirebaseAuth auth = FirebaseAuth.instance;
  static ProfileController  get instance => Get.find();
  final Rx<UserModel?> currentUser = Rx(null);
  final timeLimit = Duration(seconds: 60);

  Future<void> updateImage(XFile? image) async {
    try {
      ConstantsWidgets.showLoading();
      String? imagePath;
      if(image!=null){
        imagePath=await FirebaseFun.uploadImage(image: image);
      }
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
          .update({'photoUrl':imagePath}).timeout(timeLimit)
          .then((value){
        Get.back();
        Get.snackbar(
            "Success",
            'Successful update image',
            backgroundColor: ColorManager.successColor
        );
        Get.offAll(HomePage());
      });

    } catch (e) {
      String errorMessage;
      errorMessage = "An unexpected error occurred. Please try again later.";
      Get.back();
      Get.snackbar(
          "خطأ",
          errorMessage,
          backgroundColor: ColorManager.errorColor
      );
    }
  }
  Future<void> updateUser(
      {required String name,
        required String email,
        String? password,
        String? imagePath,
        XFile? image}) async {
    try {
      ConstantsWidgets.showLoading();
      if(image!=null){
        imagePath=await FirebaseFun.uploadImage(image: image);
      }
      if(email!=currentUser.value?.email)
        auth.currentUser?.updateEmail(email);
      if(password!=''&&password!=null)
        auth.currentUser?.updatePassword(password!);

      UserModel? userModel=UserModel(
        name: name,
        email: email,
        photoUrl: imagePath,
        uid:currentUser.value?.uid ,
        id: currentUser.value?.id,
      );
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
          .update(userModel.toJson()).timeout(timeLimit)
          .then((value){
        currentUser.value=userModel;
        update();
        Get.back();
        Get.snackbar(
            "Success",
            'Successful update user',
            backgroundColor: ColorManager.successColor
        );
        if(email!=currentUser.value?.email||(password!=''&&password!=null))
          Get.offAll(LoginPage());
      });

    } catch (e) {
      String errorMessage;
      errorMessage = "An unexpected error occurred. Please try again later.";
      Get.back();
      Get.snackbar(
          "خطأ",
          errorMessage,
          backgroundColor: ColorManager.errorColor
      );
    }
  }
  Future<void> getUser() async {
    try {

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
          .get()
          .then((value){
        currentUser.value=UserModel.fromJson(value);
        update();

        Get.snackbar(
            "Success",
            'Successful get user',
            backgroundColor: ColorManager.successColor
        );
      });

    } catch (e) {
      String errorMessage;
      errorMessage = "An unexpected error occurred. Please try again later.";
      Get.snackbar(
          "خطأ",
          errorMessage,
          backgroundColor: ColorManager.errorColor
      );
    }
  }


  ///image local
  void deletePhoto() {
    Get.back();
    profileImage = null;
    update();
  }

  Future<void> pickPhoto(ImageSource source) async {
    Get.back();
    final XFile? result = await _imagePicker.pickImage(source: source);
    if (result != null) {
      profileImage = File(result.path);
      update();
    }
  }

  @override
  void onInit() {
    _imagePicker = ImagePicker();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
