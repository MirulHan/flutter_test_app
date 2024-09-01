import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'style/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await App.initialize();

  runApp(
    GetMaterialApp(
      home: const App(),
      theme: ThemeData(
        primaryColor: AppColors.blue,
      ),
      defaultTransition: Transition.noTransition,
    ),
  );
}
