class Package{


  Package({
    required  this.id,
    required this.name,
    required    this.price,
    required    this.days,
    required    this.description,
    this.shown

  });
  int id;
  String name;
  int price;
  int days;
  String description;
  bool? shown;


  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["ID"],
    name: json["NAME"],
    price: json["PRICE"],
    days: json["DAYS"],
    description: json["DESCRIPTION"],
    shown: json['SHOWN']

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "NAME": name,
    "PRICE": price,
    "DAYS": days,
    "DESCRIPTION": description,


  };







}