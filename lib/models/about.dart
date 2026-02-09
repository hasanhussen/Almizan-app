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
}
