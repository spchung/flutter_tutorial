class TrainerModel {
  final String name;
  final String email;
  final String phone;
  final String address;

  TrainerModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    return TrainerModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }
}