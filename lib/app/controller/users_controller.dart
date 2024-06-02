

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sanad_app/app/core/utils/app_constant.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/models/user_model.dart';

import 'firebase/firebase_constants.dart';


class UsersController extends GetxController{

  final searchController = TextEditingController();
  Users users=Users(users: []);
  Users usersWithFilter=Users(users: []);
  var getUsers;
  @override
  void onInit() {
    searchController.clear();
    getUsersFun();

    super.onInit();
    }

  getUsersFun() async {
    getUsers =_fetchUsersStream();
    return getUsers;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  _fetchUsersStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionUser)
        .where('typeUser',isNotEqualTo: AppConstants.collectionAdmin)
        .snapshots();
    return result;

  }
  filterUsers({required String term}) async {
    usersWithFilter.users=[];
    users.users.forEach((element) {
      print(element.userName?.toLowerCase());
      print(term);
      print((element.userName?.toLowerCase().contains(term.toLowerCase())??false));
      if((element.name?.toLowerCase().contains(term.toLowerCase())??false)
          ||(element.userName?.toLowerCase().contains(term.toLowerCase())??false))
        usersWithFilter.users.add(element);
    });
     update();
  }

}
