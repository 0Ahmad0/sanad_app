import 'package:flutter/cupertino.dart';

class HomeUserModel {
  final String lable;
  final String image;
  final VoidCallback navigate;

  HomeUserModel({
    required this.lable,
    required this.image,
    required this.navigate,
  });
}
