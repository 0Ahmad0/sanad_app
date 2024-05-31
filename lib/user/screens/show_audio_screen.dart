import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

class ShowAudioScreen extends StatefulWidget {
  const ShowAudioScreen({Key? key}) : super(key: key);

  @override
  State<ShowAudioScreen> createState() => _ShowAudioScreenState();
}

class _ShowAudioScreenState extends State<ShowAudioScreen> {
  String? musicFile;

  @override
  void initState() {
    super.initState();
    _loadAudioFile();
  }

  void _loadAudioFile() async {
    // نسخ ملف الصوت من assets إلى مجلد مؤقت
    final byteData = await rootBundle.load('assets/sounds/enter_full_name.mp3');
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/audio1.mp3');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

    setState(() {
      musicFile = tempFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultScaffoldWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            if (musicFile != null)
              WaveBubble(
                path: musicFile,
                isSender: true,
              ),
          ],
        ),
      ),
    );
  }
}

class WaveBubble extends StatefulWidget {
  final bool isSender;
  final String? path;

  const WaveBubble({
    Key? key,
    this.isSender = false,
    this.path,
  }) : super(key: key);

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  final playerWaveStyle = PlayerWaveStyle(
    fixedWaveColor: ColorManager.primaryColor.withOpacity(.5),
    liveWaveColor: ColorManager.primaryColor,
    spacing: 6,
  );

  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.stopped) {
        setState(() {
          isCompleted = true;
        });
      } else {
        setState(() {
          isCompleted = false;
        });
      }
    });
  }

  void _preparePlayer() async {
    if (widget.path == null) {
      return;
    }

    await controller.preparePlayer(
      path: widget.path!,
      shouldExtractWaveform: true,
    );
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.path != null
        ? Column(
      children: [
        AudioFileWaveforms(
          continuousWaveform: true,
          size: Size(MediaQuery.of(context).size.width - 20, 60),
          playerController: controller,
          waveformType: WaveformType.long,
          playerWaveStyle: playerWaveStyle,
          enableSeekGesture: false,
          animationCurve: Curves.bounceIn,
        ),
        IconButton(
          onPressed: () async {
            if (controller.playerState.isPlaying ||
                controller.playerState.isStopped) {
              await controller.pausePlayer();
            } else {
              if (isCompleted) {
                await controller.seekTo(0);
                setState(() {
                  isCompleted = false;
                });
              }
              controller.setRefresh(true);
              await controller.startPlayer();
            }
          },
          icon: Icon(
            isCompleted
                ? Icons.replay
                : (controller.playerState.isPlaying ? Icons.pause : Icons.play_arrow),
            size: 60.sp,
          ),
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    )
        : const SizedBox.shrink();
  }
}
