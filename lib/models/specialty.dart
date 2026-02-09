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
    // استخدام _toInt لضمان قراءة الرقم حتى لو جاء كنص من السيرفر
    id = _toInt(json['id']) ?? 0; 
    
    // استخدام toString لضمان عدم حدوث خطأ إذا جاء الاسم كقيمة رقمية
    name = json['name']?.toString() ?? ''; 
    createdAt = json['created_at']?.toString() ?? ''; 
    updatedAt = json['updated_at']?.toString() ?? ''; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  // دالة التحويل الآمنة الخاصة بهذا الموديل
  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    if (value is double) return value.toInt();
    return null;
  }
}