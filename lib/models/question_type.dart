import 'package:almizan/models/subjects.dart';

class QuestionType {
  QuestionType(
      {required this.id,
      required this.name,
      required this.ar,
      required this.subjects,
      required this.questionCount});
  int id;
  String name;
  String ar;
  List<Subject> subjects;
  int questionCount;

  //
  bool isSelected = false;
  void toggleIsSelected() {
    isSelected = !isSelected;
  }

  factory QuestionType.fromJson(Map<String, dynamic> json) => QuestionType(
        id: json["ID"],
        name: json["NAME"],
        ar: json["AR"],
        questionCount: json["QUESTIONS_COUNT"],
        subjects: (json["CHILDREN"] == null)
            ? []
            : List<Subject>.from(
                json["CHILDREN"].map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "NAME": name,
        "AR": ar,
      };
}
