import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

class ShowVedioScreen extends StatefulWidget {
  const ShowVedioScreen({Key? key}) : super(key: key);

  @override
  State<ShowVedioScreen> createState() => _ShowVedioScreenState();
}

class _ShowVedioScreenState extends State<ShowVedioScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultScaffoldWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Vedio')
          ],
        ),
      ),
    );
  }
}
