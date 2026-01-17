class Policy{


  Policy({
    required  this.id,
    required this.title,
    required    this.body,

  });
  int id;
  String title;
  String body;


  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
    id: json["id"],
    title: json["title"],
    body: json["body"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,


  };







}