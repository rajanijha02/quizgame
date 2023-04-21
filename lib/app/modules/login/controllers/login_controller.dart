import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizgame/app/data/controllers/storage_controller.dart';
import 'package:quizgame/app/routes/app_pages.dart';

class LoginController extends GetxController {
  late StorageController storageController;
  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    storageController = Get.find<StorageController>();
    nameController.clear();
  }

  void saveName() {
    if (nameController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your name");
      return;
    }
    storageController.setName(nameController.text);
    Get.offAndToNamed(Routes.HOME);
  }
}
