class Exams {
  int? id;
  String? name;
  int? subjectId;
  int? actualDuration;
  String? createdAt;
  String? updatedAt;

  Exams({
    this.id,
    this.name,
    this.subjectId,
    this.actualDuration,
    this.createdAt,
    this.updatedAt,
  });

  Exams.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0; // تعيين قيمة افتراضية
    name = json['name'] ?? ''; // تعيين قيمة افتراضية
    subjectId = json['subject_id'] ?? 0; // تعيين قيمة افتراضية
    actualDuration = json['actual_duration'] ?? ''; // تعيين قيمة افتراضية
    createdAt = json['created_at'] ?? ''; // تعيين قيمة افتراضية
    updatedAt = json['updated_at'] ?? ''; // تعيين قيمة افتراضية
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['subject_id'] = this.subjectId;
    data['actual_duration'] = this.actualDuration;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
