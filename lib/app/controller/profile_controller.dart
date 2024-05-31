import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  late final ImagePicker _imagePicker;
  File? profileImage;

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
