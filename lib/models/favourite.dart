import 'package:almizan/models/answer.dart';

class FavouriteModel {
  FavouriteModel(
      {required this.id,
      required this.text,
      required this.img,
      required this.description,
      required this.answers,
      required this.subject,
      required this.isYear,
      required this.lesson,
      required this.year});
  int id;
  String text;
  String? img;
  String? description;
  List<Answers> answers;
  String? subject;
  int? isYear;
  String? year;
  String? lesson;
  bool isFav = false;
  bool isMark = false;
  int isAnswered = 0;
  bool showExplain = false;
  bool isSubmited = false;
  void toggleIsSelected() {
    showExplain = !showExplain;
  }

  void toggleIsMark() {
    isMark = !isMark;
  }

  void toggleisSubmited() {
    isSubmited = !isSubmited;
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
    answers.shuffle();
  }

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        id: json["ID"],
        text: json["TEXT"],
        description: json["DESCRIPTION"],
        img: json["IMAGE"],
        answers:
            List<Answers>.from(json["ANSWERS"].map((x) => Answers.fromJson(x))),
        subject: json["SUBJECT"]["NAME"],
        isYear: json["SUBJECT"]["IS_YEAR"],
        lesson: json["ITEM"]["NAME"],
        year: json["STUDY_YEAR"]["NAME"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "TEXT": text, "ANSWERS": answers, "IMAGE": img};
}
