import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/utils/assets_manager.dart';


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
