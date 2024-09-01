import 'package:flutter/material.dart';
import 'package:flutter_test_app/registry.dart';
import 'package:flutter_test_app/widgets/base_layout.dart';
import 'package:flutter_test_app/widgets/primary_column.dart';
import 'package:get/get.dart';

import '../style/colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/primary_text.dart';
import 'user_details_update_screen.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map userInfo = Registry.user!;
    int selectedIndex = 1;
    return BaseLayout(
      title: 'My Profile',
      canBack: false,
      logOutButton: true,
      bottomNav: BottomNavigation(selectedIndex: selectedIndex),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36.0),
      body: PrimaryColumn(
        gap: 24.0,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: AppColors.blue,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryText(
                    '${userInfo['firstName'][0]}${userInfo['lastName'][0]}'
                        .toUpperCase(),
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          PrimaryColumn(
            gap: 8.0,
            children: [
              PrimaryText(
                '${userInfo['firstName']} ${userInfo['lastName']}',
                fontSize: 15.0,
                color: AppColors.lightblack,
              ),
              if (userInfo['email'] != null)
                PrimaryText(
                  '${userInfo['email']}',
                  fontSize: 15.0,
                  color: AppColors.lightblack,
                ),
              if (userInfo['dob'] != null)
                PrimaryText(
                  '${userInfo['dob']}',
                  fontSize: 15.0,
                  color: AppColors.lightblack,
                ),
              if (userInfo['phone'] != null)
                PrimaryText(
                  '${userInfo['phone']}',
                  fontSize: 15.0,
                  color: AppColors.lightblack,
                ),
            ],
          ),
          PrimaryButton(
            onPressed: () => updateDetails(userInfo),
            label: 'Update my detail',
          ),
        ],
      ),
    );
  }

  void updateDetails(userInfo) {
    Get.to(
      () => UserUpdateDetailsScreen(
        user: userInfo,
      ),
      transition: Transition.cupertino,
    );
  }
}
