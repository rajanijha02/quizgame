import 'package:get/get.dart';
import 'package:quizgame/app/data/controllers/storage_controller.dart';

class StorageBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageController());
  }
}
