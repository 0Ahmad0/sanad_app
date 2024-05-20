import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';

import '../core/utils/color_manager.dart';

class TextFiledApp extends StatefulWidget {
  TextFiledApp(
      {Key? key,
      this.textInputAction = TextInputAction.next,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.iconData,
      this.hintText,
      this.obscureText = false,
      this.suffixIcon = true,
      this.validator,
      this.onChanged,
      this.onTap,
      this.autofocus = false,
      this.readOnly = false,
      this.maxLine = 1,
      this.minLine = 1,
      this.filteringTextFormatterList,
      this.prefixIcon = false,
      this.noPrefixIcon = true})
      : super(key: key);

  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final IconData? iconData;
  final String? hintText;
  final bool prefixIcon;
  final bool suffixIcon;
  final bool autofocus;
  final bool readOnly;
  final bool noPrefixIcon;
  bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final int? maxLine;
  final int? minLine;
  final List<FilteringTextInputFormatter>? filteringTextFormatterList;

  @override
  State<TextFiledApp> createState() => _TextFiledAppState();
}

class _TextFiledAppState extends State<TextFiledApp> {
  void showPassword() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.filteringTextFormatterList,
      maxLines: widget.maxLine,
      minLines: widget.minLine,
      readOnly: widget.readOnly,
      textAlign: !widget.prefixIcon ? TextAlign.start : TextAlign.center,
      autofocus: widget.autofocus,
      validator: widget.validator,
      // validator: widget.validator ??
      //     (String? val) {
      //       if (val!.trim().isEmpty) return 'This filed required';
      //       return null;
      //     },
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      style: TextStyle(fontSize: 14.sp, color: ColorManager.blackColor),
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: ColorManager.containerAuthColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide(
                  color: ColorManager.secondaryColor.withOpacity(.5),
                  width: 4)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide(
                  color: ColorManager.errorColor.withOpacity(.5), width: 2)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide:
                  BorderSide(color: ColorManager.secondaryColor, width: 4)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.0),
              borderSide: BorderSide(
                  color: ColorManager.secondaryColor.withOpacity(.8),
                  width: 4)),
          errorMaxLines: 2,
          prefixIcon: widget.prefixIcon
              ? IconButton(
                  onPressed: () {
                    showPassword();
                  },
                  icon: Icon(
                    widget.obscureText
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye,
                    color: !widget.obscureText
                        ? Theme.of(context).primaryColor
                        : ColorManager.greyColor,
                  ))
              : widget.noPrefixIcon
                  ? null
                  : Icon(widget.iconData),
          suffixIcon: widget.suffixIcon
              ? IconButton(
                  onPressed: () {},
                  icon: Image.asset(AssetsManager.nourSoundIcon),
                )
              : null,
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 14.sp, color: ColorManager.greyColor)),
    );
  }
}
