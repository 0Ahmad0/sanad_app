

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../core/utils/app_constant.dart';
import '../models/user_model.dart';

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
      if((element.name?.toLowerCase().contains(term.toLowerCase())??false)
          ||(element.userName?.toLowerCase().contains(term.toLowerCase())??false))
        usersWithFilter.users.add(element);
    });
     update();
  }

}
