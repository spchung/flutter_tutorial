class PokemonModel {
  const PokemonModel({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.description,
  });

  final int id;
  final String name;
  final String type;
  final String imageUrl;
  final String description;
}