class Specialty {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Specialty({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  Specialty.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0; // تعيين قيمة افتراضية
    name = json['name'] ?? ''; // تعيين قيمة افتراضية
    createdAt = json['created_at'] ?? ''; // تعيين قيمة افتراضية
    updatedAt = json['updated_at'] ?? ''; // تعيين قيمة افتراضية
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}