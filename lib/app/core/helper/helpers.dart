import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../main.dart';
import '../../../user/widgets/constants_widgets.dart';
import '../../widgets/constants_widgets.dart';
import '../utils/color_manager.dart';

turnAudio(String? audioPath) async {
  if (audioPath != null) {
    await audio.play(AssetSource(audioPath!));
  } else {
    ConstantsWidgets.TOAST(null,textToast:'لا يوجد صوت' ,state:false );
  }
}