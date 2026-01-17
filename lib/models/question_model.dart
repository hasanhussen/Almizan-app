import 'package:almizan/models/answer.dart';

class QuestionModel {
  QuestionModel(
      {this.id,
      this.examId,
      this.questionText,
      this.createdAt,
      this.updatedAt,
      // this.correctAnswer,
      this.answers});
  int? id;
  int? examId;
  String? questionText;
  String? createdAt;
  String? updatedAt;
  // String? correctAnswer;
  List<Answers>? answers;

  bool isFav = false;
  bool isMark = false;
  int isAnswered = 0;
  bool showExplain = false;
  bool isSubmited = false;
  Answers? rightAnswer;
  void toggleIsSelected() {
    showExplain = !showExplain;
  }

  void toggleisSubmited() {
    isSubmited = !isSubmited;
  }

  void toggleIsMark() {
    isMark = !isMark;
  }

  void checkAnswer(Answers answer) {
    if (answer.isCorrect == 1) {
      isAnswered = 1;
    } else {
      isAnswered = 2;
    }
  }

  void toggleIsFavourite() {
    isFav = !isFav;
  }

  rand() {
    answers?.shuffle();
  }

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examId = json['exam_id'];
    questionText = json['question_text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // correctAnswer = json['correct_answer'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exam_id'] = this.examId;
    data['question_text'] = this.questionText;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // data['correct_answer'] = this.correctAnswer;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
