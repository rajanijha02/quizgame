import 'package:get/get.dart';
import 'package:quizgame/app/data/question_model.dart';

class StorageController extends GetxController {
  RxString userName = "".obs;

  setName(value) {
    userName.value = value;
  }
}
