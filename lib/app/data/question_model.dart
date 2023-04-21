class Question {
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;

  Question({this.question, this.correctAnswer, this.incorrectAnswers});

  Question.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    correctAnswer = json['correct_answer'];
    incorrectAnswers = json['incorrect_answers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['correct_answer'] = correctAnswer;
    data['incorrect_answers'] = incorrectAnswers;
    return data;
  }
}
