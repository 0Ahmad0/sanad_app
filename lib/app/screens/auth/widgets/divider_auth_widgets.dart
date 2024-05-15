import 'package:flutter/material.dart';

import '../../../core/utils/values_manager.dart';

class DividerAuthWidget extends StatelessWidget {
  const DividerAuthWidget({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: AppPadding.p30),
      child: Divider(
        thickness: 2,
        color: color,
      ),
    );
  }
}
