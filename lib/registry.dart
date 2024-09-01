import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

class Registry {
  static Map? user;
  static List<dynamic>? usersData;

  static Future<void> lastUser() async {
    String? userId = GetStorage().read('userId');

    Registry.user = userId != null
        ? Registry.usersData!.where((user) => user['id'] == userId).firstOrNull
        : null;
  }

  static Future<void> userList() async {
    if (!GetStorage().hasData('usersData')) {
      final String response =
          await rootBundle.loadString('assets/users/users_data.json');
      final data = await json.decode(response);

      GetStorage().write('usersData', data);
      Registry.usersData = data;
    }

    Registry.usersData = GetStorage().read('usersData');
    return;
  }

  static Future<void> refreshUserList() async {
    final String response =
        await rootBundle.loadString('assets/users/users_data.json');
    final data = await json.decode(response);

    GetStorage().write('usersData', data);
    Registry.usersData = data;

    return;
  }

  static Future<void> addUserList(Map<String, dynamic> newUserData) async {
    List<dynamic> userList = Registry.usersData!;

    newUserData['id'] = const Uuid().v4();

    userList.add(newUserData);

    GetStorage().write('usersData', userList);
    Registry.usersData = userList;
  }

  static Future<void> modifyUserList(Map<String, dynamic> newUserData) async {
    List<dynamic> userList = Registry.usersData!;

    int userIndex =
        userList.indexWhere((user) => user['id'] == newUserData['id']);

    if (userIndex != -1) {
      userList[userIndex] = newUserData;
    }

    GetStorage().write('usersData', userList);
  }

  static Future<void> removeUserdata(String userId) async {
    List<dynamic> userList = Registry.usersData!;

    int userIndex = userList.indexWhere((user) => user['id'] == userId);

    if (userIndex != -1) {
      userList.removeAt(userIndex);
    }

    GetStorage().write('usersData', userList);
  }
}
