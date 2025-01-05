import 'package:flutter/material.dart';
import 'package:flutter_template/models/pokemon.dart';
import 'package:flutter_template/widgets/pokemons/pokemon_horizontal_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/providers/selected_pokemon.dart';
import 'package:flutter_template/utils/type_to_color.dart';
import 'package:flutter_template/providers/trainer.dart';
import 'package:flutter_template/providers/tab_navigator.dart';
import 'dart:math' as math;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPokemon = context.watch<SelectedPokemonProvider>().selectedPokemon;
    final hasSelected = context.watch<SelectedPokemonProvider>().hasSelectedPokemon;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Home'),
        backgroundColor: typeToColorFunc(selectedPokemon?.type),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PokemonHomeCard(hasSelected: hasSelected, selectedPokemon: selectedPokemon),
            const TrainerHomeCard(),
          ],
        )
      )
    );
  }
}

class TrainerHomeCard extends StatelessWidget {
  const TrainerHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final trainer = context.watch<TrainerProvider>().trainer;
    if (trainer == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            width: double.infinity,
            child: Row(
              children: [
                const Text('No Trainer found'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => context.read<TabNavigatorProvider>().setTabIndex(1),
                  child: const Text('Create Profile')
                ),
              ],
            )
          ),
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          width: double.infinity,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(trainer.name),
                      const SizedBox(width: 8),
                      Text(trainer.email),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Favorite Pokemon: '),
                      Text(trainer.favoritePokemon),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.read<TabNavigatorProvider>().setTabIndex(1),
                child: const Text('edit')
              ),
            ],
          )
        ),
      ),
    );
  }
}

class PokemonHomeCard extends StatefulWidget {
  const PokemonHomeCard({
    super.key,
    required this.hasSelected,
    required this.selectedPokemon,
  });

  final bool hasSelected;
  final PokemonModel? selectedPokemon;

  @override
  State<PokemonHomeCard> createState() => _PokemonHomeCardState();
}

// Explicit Animation with control over animation
class _PokemonHomeCardState extends State<PokemonHomeCard> with SingleTickerProviderStateMixin{
  late final AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 'this' refers to the SingleTickerProviderStateMixin
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedPokemon == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            width: double.infinity,
            child: Row(
              children: [
                const Text("No Pokemon selected"),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => context.push('/pokemons').then((value) => print(value),),
                  child: const Text('Pick Pokemon')
                ),
              ],
            )
          ),
        ),
      );
    }
    return Center(
      child: Column(
        children: [
          if (widget.hasSelected) Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    PokemonHorizontalCard(
                      pokemon: widget.selectedPokemon!,
                    ),
                    Positioned(
                      right: 0,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (_, child) {
                          if (_controller.isAnimating) {
                            return Transform.rotate(
                              angle: - _controller.value * math.pi * 4, // change to change
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
    );
  }
}