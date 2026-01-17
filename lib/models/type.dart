class Types{


  Types({
    required  this.id,
    required this.name,
    required    this.ar,
    required this.questionCount

  });
  int id;
  String name;
  String ar;
  bool isSelected = false;
  int questionCount;
  void toggleIsSelected() {
    isSelected = !isSelected;
  }
  factory Types.fromJson(Map<String, dynamic> json) => Types(
    id: json["ID"],
    name: json["NAME"],
    ar: json["AR"],
    questionCount: json["QUESTIONS_COUNT"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "NAME": name,
    "AR": ar,


  };







}