import 'package:flutter/material.dart';

import '../../../core/utils/values_manager.dart';

class DividerAuthWidget extends StatelessWidget {
  const DividerAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: AppPadding.p30),
      child: Divider(
        thickness: 2,
      ),
    );
  }
}
