import 'package:almizan/models/specialty.dart';

import 'exam.dart';

class Subject {
  int? id;
  String? name;
  String? year;
  String? semester;
  String? createdAt;
  String? updatedAt;
  List<Specialty>? specialty;
  List<Exams>? exams;

  Subject({
    this.id,
    this.name,
    this.year,
    this.specialty,
    this.semester,
    this.createdAt,
    this.updatedAt,
    // this.specialty,
    this.exams,
  });

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    year = json['year'] ?? '';
    semester = json['semester'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    if (json['specialties'] != null) {
      specialty = <Specialty>[];
      json['specialties'].forEach((v) {
        specialty!.add(Specialty.fromJson(v));
      });
    } else {
      specialty = <Specialty>[];
    }
    if (json['exams'] != null) {
      exams = <Exams>[];
      json['exams'].forEach((v) {
        exams!.add(Exams.fromJson(v));
      });
    } else {
      exams = <Exams>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['exams'] = this.exams;
    data['year'] = this.year;
    data['semester'] = this.semester;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.specialty != null) {
      data['specialty'] = this.specialty!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
