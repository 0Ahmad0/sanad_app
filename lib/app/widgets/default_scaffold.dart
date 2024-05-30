import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';

import '../core/utils/color_manager.dart';

class DefaultScaffoldWidget extends StatelessWidget {
  const DefaultScaffoldWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
     Image.asset(
          AssetsManager.backgroundAppIMG,
          width: size.width,
          height: size.height,
          fit: BoxFit.cover,
        ) ,
        child ?? const SizedBox.shrink(),
      ],
    );
  }
}
