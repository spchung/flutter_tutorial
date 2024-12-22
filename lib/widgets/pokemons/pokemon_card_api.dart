import 'package:flutter/material.dart';
import 'package:flutter_template/models/pokemon.dart';
import 'package:flutter_template/widgets/pokemons/pokemons.dart';

class PokemonCardApiPage extends StatelessWidget {
  const PokemonCardApiPage({
    super.key,
    required this.pokemon,
    required this.pokedexId,
  });

  final PokemonModel pokemon;
  final String pokedexId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon API'),
      ),
      body: PokemonCard(pokemon: pokemon),
    );
  }
}