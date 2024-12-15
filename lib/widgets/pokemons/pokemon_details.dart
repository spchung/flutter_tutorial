import 'package:flutter/material.dart';
import 'package:flutter_template/models/pokemon.dart';
import 'package:flutter_template/providers/selected_pokemon.dart';
import 'package:provider/provider.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({
    super.key,
    required this.pokemon,
  });

  final PokemonModel pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: pokemon.imageUrl,
              child: Image.network(
                pokemon.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pokemon.type,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    pokemon.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SelectedPokemonProvider>().selectPokemon(pokemon);
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: const Text('Select this boy'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}