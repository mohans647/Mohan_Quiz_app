import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controllers/quiz_controller.dart';
import '../custom_widgets/question_card.dart';
import '../services/utils/constants.dart';

class QuizPage extends StatelessWidget {
  final QuizController controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appSecondaryColor,
        title: Text('Quiz-App',style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        if (controller.questions.isEmpty) {
          return const Center(
            child: Text(
              'No questions available. Please try again later.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final question = controller.questions[controller.currentQuestionIndex.value];
        final selectedAnswer = controller.selectedAnswers.isNotEmpty &&
            controller.selectedAnswers.length > controller.currentQuestionIndex.value
            ? controller.selectedAnswers[controller.currentQuestionIndex.value]
            : null;

        return Column(
          children: [
            // Display timer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Time: ${controller.elapsedTime.value}s",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total Questions: ${controller.questions.length}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            // Question Card
            Expanded(
              child: QuestionCard(
                question: question,
                selectedAnswer: selectedAnswer,
                onAnswerSelected: (index) {
                  controller.selectAnswer(index);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.currentQuestionIndex.value > 0)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appSecondaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: controller.previousQuestion,
                      child: Text('Back'),
                    ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appSecondaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    onPressed: () {
                      if (controller.selectedAnswers.length <=
                          controller.currentQuestionIndex.value ||
                          controller.selectedAnswers[controller.currentQuestionIndex.value] ==
                              null) {
                        Fluttertoast.showToast(
                          msg: "Please select an answer before proceeding.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        controller.nextQuestion(
                          controller.selectedAnswers[controller.currentQuestionIndex.value] ==
                              question.answer,
                        );
                      }
                    },
                    child: Text(controller.currentQuestionIndex.value < controller.questions.length - 1
                        ? 'Next'
                        : 'Submit'),
                  )

                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
