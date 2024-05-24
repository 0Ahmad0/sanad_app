import 'package:get/get.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';

import '../models/home_user_model.dart';

class UserController extends GetxController{

  List<HomeUserModel> homeButton = [
    HomeUserModel(lable: AppString.showLessons, image: AssetsManager.showLessonsIcon, navigate: () {  }),
    HomeUserModel(lable: AppString.requestLessons, image: AssetsManager.requestLessonsIcon, navigate: () {  }),
    HomeUserModel(lable: AppString.rateLessons, image: AssetsManager.rateLessonsIcon, navigate: () {  }),
    HomeUserModel(lable: AppString.questionLesson, image: AssetsManager.questionsLessonsIcon, navigate: () {  }),
  ];

}