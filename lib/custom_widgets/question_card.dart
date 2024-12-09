import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/utils/constants.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  final int? selectedAnswer;
  final Function(int) onAnswerSelected;

  QuestionCard({super.key,
    required this.question,
    required this.onAnswerSelected,
    this.selectedAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return
      Card(
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: appSecondaryColor), // Set border color here
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.question,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ...List.generate(
                question.options.length,
                    (index) => ListTile(
                      title: Text(question.options[index]),
                  leading: Radio<int>(
                    value: index,
                    groupValue: selectedAnswer, // Reflect the selected answer
                    onChanged: (value) {
                      onAnswerSelected(index); // Notify parent about the selection
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  }
}
