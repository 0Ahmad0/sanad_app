import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../main.dart';
import '../utils/color_manager.dart';

turnAudio(String? audioPath) async {
  if (audioPath != null) {
    await audio.play(AssetSource(audioPath!));
  } else {
    Get.snackbar('خطأ', 'لا يوجد صوت',
        colorText: ColorManager.whiteColor,
        backgroundColor: ColorManager.errorColor);
  }
}