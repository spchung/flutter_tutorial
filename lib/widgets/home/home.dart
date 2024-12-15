import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/providers/selected_pokemon.dart';
import 'package:flutter_template/widgets/pokemons/pokemon_home_card.dart';
import 'package:flutter_template/utils/type_to_color.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final selectedPokemon = context.watch<SelectedPokemonProvider>().selectedPokemon;
    final hasSelected = context.watch<SelectedPokemonProvider>().hasSelectedPokemon;

    if (selectedPokemon != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon Home'),
          backgroundColor: typeToColorFunc(selectedPokemon.type),
        ),
        body:SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (hasSelected) Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        PokemonHomeCard(pokemon: selectedPokemon),
                        Positioned(
                          right: 0,
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (_, child) {
                              if (_controller.isAnimating) {
                                return Transform.rotate(
                                  angle: -_controller.value * 2 * math.pi,
                                  child: child,
                                );
                              } 
                              return child!;
                            },
                            child: IconButton(
                              iconSize: 35,
                              onPressed: () {
                                _controller.repeat();
                                Future.delayed(const Duration(seconds: 1), () {
                                  _controller.stop();
                                  if (context.mounted){
                                    context.push('/pokemons');
                                  }
                                });
                              },
                              icon: const Icon(Icons.catching_pokemon_outlined),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ),
            ],
          )
        ),
      )
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Home'),
        backgroundColor: Colors.grey[100],
      ),
      body: Center(
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
      ),
    );
  }
}