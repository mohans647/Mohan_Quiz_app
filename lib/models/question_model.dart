class QuestionModel {
  final int id;
  final String question;
  final List<String> options;
  final int answer;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }
}
