import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/question_model.dart';
import '../services/local_storage_service.dart';
import '../views/QuizAnalyticsPage.dart';

class QuizController extends GetxController {
  final LocalStorageService _storage = LocalStorageService();
  var questions = <QuestionModel>[].obs;
  var selectedAnswers = <int?>[].obs;
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var startTime = DateTime.now().obs;
  var elapsedTime = 0.obs;
  var showFeedback = false.obs;
  var isAnswerCorrect = false.obs;
  var selectedAnswer = Rxn<int>();
  var correctAnswersCount = 0.obs;
  var incorrectAnswersCount = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    loadQuestions();
    restoreProgress();
    super.onInit();
  }

  void loadQuestions() async {
    try {
      final jsonString = await DefaultAssetBundle.of(Get.context!).loadString('assets/questions.json');
      final jsonData = jsonDecode(jsonString) as List;
      if (jsonData.isEmpty) {
        Get.snackbar('Error', 'No questions found in the JSON file');
      } else {
        questions.value = jsonData.map((data) => QuestionModel.fromJson(data)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load questions: $e');
      print('Error loading questions: $e');
    }
  }

  void startQuestionTimer() {
    elapsedTime.value = 0;
    startTime.value = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedTime.value++;
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
  void selectAnswer(int index) {
    if (selectedAnswers.length <= currentQuestionIndex.value) {
      selectedAnswers.add(null);
    }
    selectedAnswers[currentQuestionIndex.value] = index;
  }

  void nextQuestion(bool isCorrect) {
    // Update analytics based on the current question
    if (isCorrect) {
      correctAnswersCount.value++;
    } else {
      incorrectAnswersCount.value++;
    }
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    } else {

      Get.snackbar(
        'Quiz Completed',
        'You scored ${correctAnswersCount.value} out of ${questions.length}',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.to(
        QuizAnalyticsPage(),
        transition: Transition.noTransition,
      );

    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  // Calculate final results
  Map<String, dynamic> getAnalytics() {
    int totalQuestions = questions.length;
    int unansweredQuestions = totalQuestions - selectedAnswers.where((a) => a != null).length;
    double accuracy = correctAnswersCount.value / totalQuestions * 100;

    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswersCount.value,
      'incorrectAnswers': incorrectAnswersCount.value,
      'unansweredQuestions': unansweredQuestions,
      'accuracy': accuracy.toStringAsFixed(2),
    };
  }

  void saveProgress() {
    _storage.saveProgress(currentQuestionIndex.value);
  }

  void restoreProgress() async {
    currentQuestionIndex.value = await _storage.getProgress();
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }
}
