import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/registry.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../app.dart';
import '../screens/homepage_screen.dart';
import '../screens/user_profile_screen.dart';
import '../style/colors.dart';
import 'primary_text.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({
    super.key,
    this.title,
    this.body,
    this.isappbar = true,
    this.padding = const EdgeInsets.all(16.0),
    this.canBack = true,
    this.bottomNav,
    this.logOutButton = false,
    this.isScrollable = false,
    this.onpressedActionButton,
  });

  final String? title;
  final Widget? body;
  final bool isappbar;
  final EdgeInsetsGeometry padding;
  final bool canBack;
  final Widget? bottomNav;
  final bool logOutButton;
  final bool isScrollable;
  final Function()? onpressedActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: isappbar
          ? PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(128, 128, 128, 0.5),
                      spreadRadius: 2.0,
                      blurRadius: 14.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: AppBar(
                  scrolledUnderElevation: 0.0,
                  leading: canBack
                      ? IconButton(
                          iconSize: 20.0,
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Get.back();
                          },
                        )
                      : null,
                  centerTitle: false,
                  title: PrimaryText(
                    title ?? '',
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.white,
                  actions: [
                    if (logOutButton)
                      TextButton(
                        onPressed: () {
                          Registry.user = null;
                          GetStorage().erase();
                          Get.offAll(
                            () => const App(),
                            transition: Transition.cupertino,
                          );
                        },
                        child: PrimaryText(
                          'Logout',
                          fontSize: 16.0,
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            )
          : null,
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNav,
      body: isScrollable
          ? SingleChildScrollView(
              child: Padding(padding: padding, child: body),
            )
          : Padding(padding: padding, child: body),
      floatingActionButton: onpressedActionButton != null
          ? FloatingActionButton(
              onPressed: onpressedActionButton,
              backgroundColor: AppColors.blue,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30.0,
              ),
            )
          : null,
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    this.selectedIndex = 0,
  });

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.lightGray,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: SvgPicture.asset(
                'assets/icons/bottom-nav-icon.svg',
                height: 30.0,
                colorFilter: selectedIndex == 0
                    ? ColorFilter.mode(AppColors.blue, BlendMode.srcIn)
                    : ColorFilter.mode(AppColors.darkGray, BlendMode.srcIn),
              ),
              onTap: () {
                if (selectedIndex != 0) {
                  Get.off(
                    () => const HomePageScreen(),
                    transition: Transition.cupertino,
                  );
                }
              },
            ),
            InkWell(
              child: Icon(
                Icons.person_outline,
                color: selectedIndex == 1 ? AppColors.blue : AppColors.darkGray,
                size: 30.0,
              ),
              onTap: () {
                if (selectedIndex != 1) {
                  Get.off(
                    () => const MyProfileScreen(),
                    transition: Transition.cupertino,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
