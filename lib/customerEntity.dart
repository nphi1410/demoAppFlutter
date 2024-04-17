class Customer {
  int? id;
  String? name;
  DateTime birthday;
  String? gender;
  String? country;

  Customer({
    this.id,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.country,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      birthday: DateTime.parse(json['birthday']),
      gender: json['gender'],
      country: json['country'],
    );
  }

}

List<String> countries = [
  'Russia',
  'Ireland',
  'Cuba',
  'Japan',
  'Indonesia',
  'Sweden',
  'France',
  'Iran',
  'China',
  'Slovenia',
  'Peru',
  'Philippines',
  'Laos',
  'Vietnam',
];


