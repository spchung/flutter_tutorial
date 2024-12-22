class PokemonModel {
    PokemonModel({
        required this.id,
        required this.name,
        required this.type,
        required this.imageUrl,
        required this.description,
    });

    final int id;
    final String name;
    final String type;
    String imageUrl;
    final String description;

    factory PokemonModel.fromJson(Map<String, dynamic> json) {
        return PokemonModel(
            id: json['id'],
            name: json['name'],
            type: json['types'][0]['type']['name'],
            imageUrl: json['sprites']['other']['official-artwork']['front_default'],
            description: '',
        );
    }
}

class PokemonListModel {
    List<PokemonListResult> results;

    PokemonListModel({
        required this.results,
    });

    factory PokemonListModel.fromJson(Map<String, dynamic> json) {
        return PokemonListModel(
            results: List<PokemonListResult>.from(json['results'].map((x) => PokemonListResult.fromJson(x))),
        );
    }
}

class PokemonListResult {
    String name;
    String url;

    PokemonListResult({
        required this.name,
        required this.url,
    });

    factory PokemonListResult.fromJson(Map<String, dynamic> json) {
        return PokemonListResult(
            name: json['name'],
            url: json['url'],
        );
    }
}
