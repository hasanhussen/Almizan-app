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
    id = _toInt(json['id']) ?? 0; 
    name = json['name']?.toString() ?? ''; 
    subjectId = _toInt(json['subject_id']) ?? 0;
    
    // تصحيح الخطأ: لا يمكن وضع '' في متغير int
    actualDuration = _toInt(json['actual_duration']) ?? 0; 
    
    createdAt = json['created_at']?.toString() ?? ''; 
    updatedAt = json['updated_at']?.toString() ?? ''; 
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

  // دالة التحويل لضمان عدم حدوث Type Mismatch
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }
}