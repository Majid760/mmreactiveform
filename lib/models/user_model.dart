class User {
  String? name;
  String? city;
  String? address;
  String? country;
  int? age;
  String? cnic;

  User({this.name, this.city, this.address, this.country, this.age, this.cnic});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    address = json['address'];
    country = json['country'];
    age = json['age'];
    cnic = json['cnin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['city'] = city;
    data['address'] = address;
    data['country'] = country;
    data['age'] = age;
    data['cnin'] = cnic;
    return data;
  }
}
