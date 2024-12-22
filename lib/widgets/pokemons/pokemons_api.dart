import 'dart:math';
import 'dart:convert';
import 'package:flutter_template/widgets/shared/loading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_template/models/pokemon.dart';
import 'package:flutter_template/widgets/pokemons/pokemon_details.dart';

class PokemonsApiPage extends StatelessWidget {
  const PokemonsApiPage({super.key});

  String getPokemonId (String url) {
    final uri = Uri.parse(url);
    return uri.pathSegments[uri.pathSegments.length - 2];
  }

  @override
  Widget build(BuildContext context) {
    final rng = Random();
    final endpoint = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=6&offset=${rng.nextInt(100)}');
    return Scaffold(
        appBar: AppBar(
            title: const Text('Pokemons API'),
        ),
        body: FutureBuilder(
            future: http.get(endpoint),
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: SizedBox.shrink());
                }
                if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                }
                final pokemonListModel = PokemonListModel.fromJson(json.decode(snapshot.data!.body));
                return GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.9,

                    children: [
                        for (var pokemonRes in pokemonListModel.results)
                            FutureBuilder(
                                future: http.get(Uri.parse(pokemonRes.url)),
                                builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: PokeballLoadingWidget());
                                    }
                                    if (snapshot.hasError) {
                                        return const Center(child: Text('Error fetching data'));
                                    }
                                    final pokemonModel = PokemonModel.fromJson(json.decode(snapshot.data!.body));
                                    final pokedexId = getPokemonId(pokemonRes.url);
                                    final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokedexId.png';
                                    final imageBody = Image.network(imageUrl);
                                    return GestureDetector(
                                        onTap: () {
                                            Navigator.push(
                                                context, 
                                                MaterialPageRoute(
                                                    builder: (context) => PokemonDetailPage(
                                                        pokemon: pokemonModel,
                                                    )
                                                ),
                                            );
                                        },
                                        child: Card(
                                            child: Column(
                                                children: [
                                                    Hero(
                                                        tag: imageUrl,
                                                        child: imageBody
                                                    ),
                                                    Text(pokemonRes.name)
                                                ],
                                            ),
                                        ),
                                    );
                                },
                            ),
                    ],
                );
            }
        )
    );
  }
}