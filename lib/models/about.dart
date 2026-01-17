class AppInfoModel {
  String? text;
  String? note;
  String? instagram;
  String? facebook;

  AppInfoModel({
    this.text,
    this.note,
    this.instagram,
    this.facebook,
  });

  AppInfoModel.fromJson(Map<String, dynamic> json) {
    text = json['text'] ?? '';
    note = json['note'] ?? '';
    instagram = json['instagram'] ?? '';
    facebook = json['facebook'] ?? '';
  }

  //   Answers.fromJson(Map<String, dynamic> json) {
  //       id = json['id'];
  //       questionId = json['question_id'];
  //       answerText = json['answer_text'];
  //       isCorrect = json['is_correct'];
  //       createdAt = json['created_at'];
  //       updatedAt = json['updated_at'];
  // }
}
