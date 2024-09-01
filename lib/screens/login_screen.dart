import 'package:flutter/material.dart';
import 'package:flutter_test_app/registry.dart';
import 'package:flutter_test_app/widgets/base_layout.dart';
import 'package:flutter_test_app/widgets/primary_column.dart';
import 'package:flutter_test_app/widgets/primary_text.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../style/colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/primary_text_field.dart';
import 'homepage_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? userId = '';
  String? error;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      isappbar: false,
      title: 'Login',
      padding: const EdgeInsets.fromLTRB(24.0, 70.0, 24.0, 0.0),
      body: PrimaryColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        gap: 32.0,
        children: [
          PrimaryColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            gap: 6.0,
            children: [
              PrimaryText(
                'Hi There!',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.blue,
              ),
              PrimaryText(
                'Please login to see your contact list',
                fontSize: 12.0,
                color: AppColors.black,
              ),
            ],
          ),
          PrimaryTextField(
            label: 'User ID',
            prefixIcon: Icon(
              Icons.person_outline,
              color: AppColors.blue,
            ),
            hintText: 'eg. 5c8a80f52dfee238898d64cf',
            initialValue: userId,
            error: error,
            onChanged: (value) {
              userId = value;
            },
          ),
          PrimaryButton(
            onPressed: login,
            label: 'Login',
          ),
        ],
      ),
    );
  }

  void login() {
    setState(() {
      error = null;
    });

    if (userId == null || userId!.isEmpty) {
      error = 'Please enter a valid user ID';
      return;
    }

    var user =
        Registry.usersData!.where((user) => user['id'] == userId).firstOrNull;

    if (user == null) {
      error = 'User not found';
      return;
    }

    Registry.user = user;
    GetStorage().write('userId', user['id']);
    Get.off(
      () => const HomePageScreen(),
      transition: Transition.cupertino,
    );
  }
}
