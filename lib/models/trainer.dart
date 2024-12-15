class TrainerModel {
  final String name;
  final String email;
  final String favoritePokemon;

  TrainerModel({
    required this.name,
    required this.email,
    required this.favoritePokemon,
  });

  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    return TrainerModel(
      name: json['name'],
      email: json['email'],
      favoritePokemon: json['favoritePokemon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'favoritePokemon': favoritePokemon,
    };
  }
}