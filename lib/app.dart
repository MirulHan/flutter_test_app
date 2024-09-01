import 'package:flutter/material.dart';
import 'package:flutter_test_app/screens/login_screen.dart';
import 'package:get_storage/get_storage.dart';

import 'registry.dart';
import 'screens/homepage_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return attemptGetLandingScreen();
  }

  static Widget attemptGetLandingScreen() {
    if (Registry.user != null) {
      return const HomePageScreen();
    }

    return const LoginScreen();
  }

  static initialize() async {
    await GetStorage.init();
    await Registry.userList();
    await Registry.lastUser();
  }
}
