import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/providers/selected_pokemon.dart';
import 'package:flutter_template/widgets/pokemons/pokemon_home_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final selectedPokemon = context.watch<SelectedPokemonProvider>().selectedPokemon;
    if (selectedPokemon != null) {
      return Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      PokemonHomeCard(pokemon: selectedPokemon),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          iconSize: 35,
                          onPressed: () => context.push('/pokemons'),
                          icon: const Icon(Icons.change_circle_outlined),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding:EdgeInsets.all(8.0),
              child: Text("No Pokemon selected"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => context.push('/pokemons'),
                child: const Text('Pick Pokemon')
              ),
            ),
          ],
        ),
      )
    );
  }
}
