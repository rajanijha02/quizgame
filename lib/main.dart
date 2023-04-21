import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quizgame/app/data/bindings.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialBinding: StorageBindings(),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
