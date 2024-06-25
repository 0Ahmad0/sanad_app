import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../core/utils/app_string.dart';
import '../core/utils/color_manager.dart';
import '../core/utils/values_manager.dart';



class ConstantsWidgets {

  static circularProgress()  {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
    static showLoading() async {
    return await Get.dialog(
      PopScope(
          canPop:true
       ,
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
  static closeDialog() async {
    Get.close(1);

  }
  static showProgress(double progress)  {
    return
      // await Get.dialog(
      PopScope(
        canPop:true
        ,
        child: Center(
          child: Container(
             width: 100,
             height: 100,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitWave(
                  size: 46,

                  color: ColorManager.primaryColor,
                ),
                SizedBox(height: AppSize.s10,),
                Text('${(progress*100).toInt()}%',style: TextStyle(fontSize: 14,color:ColorManager.textFieldColor ),)
              ],
            ),
          ),
        ),
      );
    //   barrierDismissible: false,
    // );
  }
  static TOAST(BuildContext? context, {String? title,String textToast = "This Is Toast",bool? state}) {
    title??=state==null?AppString.message_success:state?AppString.message_success:AppString.message_failure;
    Get.snackbar(title, textToast,
        backgroundColor: state==null?null:state?ColorManager.successColor:ColorManager.errorColor,
        colorText:  ColorManager.whiteColor);
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
        fontSize: MediaQuery.of(context).size.width * 0.06,
        fontWeight: FontWeight.bold
    ),),
  );
}
