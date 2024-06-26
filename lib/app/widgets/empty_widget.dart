import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/color_manager.dart';
import '../core/utils/styles_manager.dart';

import '../core/utils/assets_manager.dart';
import '../core/utils/values_manager.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,  this.text = 'لا يوجد شيء لعرضه',
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsManager.emptyBoxIcon,
            width: 120.sp,
            height: 120.sp,
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Text(
            '☹️  ' + text + '  ☹️',
            textAlign: TextAlign.center,
            style: StylesManager.textNormalStyle(
              color: ColorManager.primaryColor,
              size: 16.sp
            ),
          ),
        ],
      ),
    );
  }
}
