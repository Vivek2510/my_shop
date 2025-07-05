import 'dart:convert';

import 'package:flutter/material.dart';

import '../constant/import.dart';
import '../floor/app_database.dart';
import 'package:rxdart/rxdart.dart';

class LoginUser {
  LoginUser._internal();

  static final LoginUser _instance = LoginUser._internal();

  static LoginUser get instance => _instance;
  bool isLoggedIn = false;
  var startTime = DateTime.now();
  BehaviorSubject<bool> didUpdateUserProfile = BehaviorSubject<bool>();
  BehaviorSubject<bool> didUpdateLanguageData = BehaviorSubject<bool>();
  bool isDarkTheme = false;
  String userId = "testUserId";
  List<String> userSearchStrings = [];

  MDLUser? user;
  var floorDataBase;

  Future<void> initializationDatabase() async {
    floorDataBase =
        await $FloorAppDatabase
            .databaseBuilder('project_struct_flutter_database.db')
            .build();
  }

  Future retrieveLoggedInUserDetail() async {
    try {
      debugPrint('retrieveLoggedInUserDetail == =');
      var users = await LoginUser.instance.floorDataBase.userDao.findAllUsers();
      if (users.isNotEmpty) {
        user = users.first;
        final decoded = jsonDecode(user?.searchKey ?? '[]');
        if (decoded is List) {
          userSearchStrings = decoded.map((e) => e.toString()).toList();
        }
        isLoggedIn = true;
      } else {
        isLoggedIn = false;
        debugPrint('USER IS NOT LOGGED IN == =');
      }
    } catch (e) {
      isLoggedIn = false;
      debugPrint('USER IS NOT LOGGED IN == =');
    }
  }

  Future<void> storeUserDataToLocal(MDLUser userInfo) async {
    await floorDataBase.userDao.delete();
    await floorDataBase.userDao.insertUser(userInfo);
    await LoginUser.instance.retrieveLoggedInUserDetail();
  }

  Future<void> updateNotificationFlag(int? notificationFlag) async {
    try {
      await floorDataBase.userDao.updateNotificationFlag(notificationFlag);
      await LoginUser.instance.retrieveLoggedInUserDetail();
    } catch (e) {
      e.toString();
    }
  }

  Future<void> logout() async {
    await floorDataBase.userDao.delete();
    isLoggedIn = false;
    user = null;
  }
}
