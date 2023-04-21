import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quiz Game",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          /**
           *========================
           * Question Count WIdget
           *========================
           */

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => controller.started.isTrue
                  ? Text(
                      "${controller.currentQuestion.value + 1}/ ${controller.questions.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(
        /**
         *========================
         * Loading Widget
         *========================
         */
        () => controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            /**
               * 
               * 
               *========================
               * Questions Widgets
               *========================
               * 
               * 
               */

            : controller.started.isTrue
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              controller
                                      .questions[
                                          controller.currentQuestion.value]
                                      .question ??
                                  "",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        /**
                         *========================
                         * Options Widgets
                         *========================
                         */
                        ...controller
                            .questions[controller.currentQuestion.value]
                            .incorrectAnswers!
                            .map(
                              (e) => Obx(
                                () => InkWell(
                                  onTap: () {
                                    if (controller.blockResponse.isTrue) {
                                      Get.showSnackbar(
                                        const GetSnackBar(
                                          message: "Please wait",
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      controller.selectedAnswer.value = e;
                                      if (controller.selectedAnswer.value ==
                                          controller
                                              .questions[controller
                                                  .currentQuestion.value]
                                              .correctAnswer) {
                                        controller.correctAnswers++;
                                      }
                                      controller.block();
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          controller.selectedAnswer.value == e
                                              ? Colors.lightGreenAccent
                                              : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),





                        /**
                         * 
                         * ==================
                         * Last Option Code
                         * ==================
                         * 
                         */
                            
                        InkWell(
                          onTap: () {
                            if (controller.blockResponse.isTrue) {
                              Get.showSnackbar(
                                const GetSnackBar(
                                  message: "Please wait",
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else {
                              controller.selectedAnswer.value = controller
                                      .questions[
                                          controller.currentQuestion.value]
                                      .correctAnswer ??
                                  "";
                              if (controller.selectedAnswer.value ==
                                  controller
                                      .questions[
                                          controller.currentQuestion.value]
                                      .correctAnswer) {
                                controller.correctAnswers++;
                              }
                              controller.block();
                            }
                          },
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: controller.selectedAnswer.value ==
                                      controller
                                          .questions[
                                              controller.currentQuestion.value]
                                          .correctAnswer
                                  ? Colors.lightGreenAccent
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller
                                      .questions[
                                          controller.currentQuestion.value]
                                      .correctAnswer ??
                                  "",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),





                        /**
                         * 
                         *========================
                         * Correct/Incorrect Widget
                         *========================
                         * 
                         */

                        Obx(
                          () => controller.selectedAnswer.value != ""
                              ? Text(
                                  controller.selectedAnswer.value ==
                                          controller
                                              .questions[controller
                                                  .currentQuestion.value]
                                              .correctAnswer
                                      ? "Correct"
                                      : "Incorrect",
                                  style: TextStyle(
                                    color: controller.selectedAnswer.value ==
                                            controller
                                                .questions[controller
                                                    .currentQuestion.value]
                                                .correctAnswer
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  )
                /**
                   * 
                   *========================= 
                   * Result Widgets
                   *=========================
                   * 
                   */
                : controller.showAnswer.isTrue
                    ? Container(
                        height: 300,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Your Score is ${controller.correctAnswers}/${controller.questions.length}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                controller.loadQuestion();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                  ),
                                  alignment: Alignment.center,
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.grey.shade100,
                                        size: 70,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Restart Quiz",
                                        style: TextStyle(
                                          color: Colors.grey.shade100,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    /**
                       * 
                       * 
                       *============================== 
                       * Quiz Start Widget 
                       *==============================
                       * 
                       * 
                       */
                    : InkWell(
                        onTap: () {
                          controller.loadQuestion();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            alignment: Alignment.center,
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Colors.grey.shade100,
                                  size: 70,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Start Quiz",
                                  style: TextStyle(
                                    color: Colors.grey.shade100,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
      ),
    );
  }
}
