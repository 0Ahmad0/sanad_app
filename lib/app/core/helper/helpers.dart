import 'package:audioplayers/audioplayers.dart';

import '../../../main.dart';
import '../../widgets/constants_widgets.dart';

turnAudio(String? audioPath) async {
  if (audioPath != null) {
    await audio.play(AssetSource(audioPath));
  } else {
    ConstantsWidgets.TOAST(null,textToast:'لا يوجد صوت' ,state:false );
  }
}