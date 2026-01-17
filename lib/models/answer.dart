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
            id = json['id'];
            questionId = json['question_id'];
            answerText = json['answer_text'];
            isCorrect = json['is_correct'];
            createdAt = json['created_at'];
            updatedAt = json['updated_at'];
      }

      Map<String, dynamic> toJson() {
            final Map<String, dynamic> data = new Map<String, dynamic>();
            data['id'] = this.id;
            data['question_id'] = this.questionId;
            data['answer_text'] = this.answerText;
            data['is_correct'] = this.isCorrect;
            data['created_at'] = this.createdAt;
            data['updated_at'] = this.updatedAt;
            return data;
      }
}