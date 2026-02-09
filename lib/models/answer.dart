class Answers {
  int? id;
  int? questionId;
  String? answerText;
  int? isCorrect;
  String? createdAt;
  String? updatedAt;

  Answers(
      {this.id,
      this.questionId,
      this.answerText,
      this.isCorrect,
      this.createdAt,
      this.updatedAt});

  Answers.fromJson(Map<String, dynamic> json) {
    id = _toInt(json['id']); // تحويل آمن
    questionId = _toInt(json['question_id']); // تحويل آمن
    answerText = json['answer_text']?.toString();
    isCorrect = _toInt(json['is_correct']); // تحويل آمن (غالباً ما يأتي 0 أو 1)
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_id'] = questionId;
    data['answer_text'] = answerText;
    data['is_correct'] = isCorrect;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // دالة التحويل الآمنة للـ int
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }
}