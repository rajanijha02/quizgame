import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quizgame/app/data/question_model.dart';

class HomeController extends GetxController {
  RxList<Question> questions = <Question>[].obs;

  RxBool started = false.obs;
  RxBool isLoading = false.obs;
  RxBool blockResponse = false.obs;
  RxBool showAnswer = false.obs;

  int correctAnswers = 0;
  RxInt currentQuestion = 0.obs;
  RxString selectedAnswer = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  loadQuestion() async {
    try {
      currentQuestion.value = 0;
      selectedAnswer.value = '';
      showAnswer.value = false;
      correctAnswers = 0;

      isLoading.value = true;
      http.Response response = await http.post(
        Uri.parse(
            'https://opentdb.com/api.php?amount=10&category=18&type=multiple'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['results'];
        questions.value =
            data.map<Question>((e) => Question.fromJson(e)).toList();
        started.value = true;
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  block() {
    blockResponse.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      blockResponse.value = false;
      if (currentQuestion.value < questions.length - 1) {
        print('Hello');
        currentQuestion.value++;
        selectedAnswer.value = '';
      } else {
        print('World');
        showAnswer.value = true;
        started.value = false;
      }
    });
  }
}
