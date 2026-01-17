class UserPackage{


  UserPackage({
    required  this.id,
    required this.name,
    required    this.price,
    required    this.days,
    required    this.description,
required this.subscriped,
    this.endDate
  });
  int id;
  String name;
  int price;
  int days;
  String description;
  bool subscriped=false ;
  String? endDate;
  //


  factory UserPackage.fromJson(Map<String, dynamic> json) => UserPackage(
    id: json["ID"],
    name: json["NAME"],
    price: json["PRICE"],
    days: json["DAYS"],
    description: json["DESCRIPTION"],
    subscriped: json['SUBSCRIPED']??false,
    endDate: json['END_DATE']

  );



 int duration(){
    DateTime date = DateTime.parse(endDate!);
    DateTime startDate = DateTime.now();
    Duration difference = date.difference(startDate);
    int days = difference.inDays;
return days;

  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "NAME": name,
    "PRICE": price,
    "DAYS": days,
    "DESCRIPTION": description,


  };







}