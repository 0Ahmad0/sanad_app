import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/route/app_route.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';

import '../models/home_user_model.dart';
import '../models/question_model.dart';

class UserController extends GetxController {
  List<HomeUserModel> homeButton = [
    HomeUserModel(
        lable: AppString.showLessons,
        image: AssetsManager.showLessonsIcon,
        navigate: () {
          Get.toNamed(AppRoute.lessonsUserRoute);
        }),
    HomeUserModel(
        lable: AppString.requestLessons,
        image: AssetsManager.requestLessonsIcon,
        navigate: () {
          Get.toNamed(AppRoute.managingLessonUserRoute);

        }),
    HomeUserModel(
        lable: AppString.rateLessons,
        image: AssetsManager.rateLessonsIcon,
        navigate: () {
          Get.toNamed(AppRoute.rateLessonUserRoute);
        }),
    HomeUserModel(
        lable: AppString.questionLesson,
        image: AssetsManager.questionsLessonsIcon,
        navigate: () {
          Get.toNamed(AppRoute.questionUserRoute);
        }),
  ];

  final searchController = TextEditingController();

  static List<Question> questions = [
    Question(
        text: 'text', options: ['1', '2', '3', '4'], correctOptionIndex: 3),
    Question(
        text: 'text', options: ['1', '2', '3', '4'], correctOptionIndex: 3),
    Question(
        text: 'text', options: ['1', '2', '3', '4'], correctOptionIndex: 3),
  ];

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
