import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../core/utils/color_manager.dart';



class ConstantsWidgets {
  static showLoading() async {
    return await Get.dialog(
      PopScope(
          canPop:false,
        child: Center(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SpinKitWave(
              size: 40,
              color: ColorManager.primaryColor,
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  static circularProgress()  {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  static TOAST(BuildContext context, {String textToast = "This Is Toast"}) {
     Get.snackbar('title', textToast);
    // showToast(
    //     textToast,
    //     context: context,
    //     animation: StyledToastAnimation.fadeScale,
    //     position: StyledToastPosition.top,
    //     textStyle: TextStyle(color: ColorManager.whiteColor)
    // );
  }

  static emptyWidget(context,{text='No Data Yet!'})=>Center(
    child: Text(text,style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.08,
        fontWeight: FontWeight.bold
    ),),
  );
}
