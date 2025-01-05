import 'package:flutter/material.dart';
import 'package:flutter_template/models/pokemon.dart';
import 'package:flutter_template/providers/selected_pokemon.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

/* 
  Animations
*/

class AnimatedPokemonDetailPage extends StatefulWidget {
  const AnimatedPokemonDetailPage({
    super.key,
    required this.pokemon,
  });

  final PokemonModel pokemon;

  @override
  State<AnimatedPokemonDetailPage> createState() => _AnimatedPokemonDetailPageState();
}

class _AnimatedPokemonDetailPageState extends State<AnimatedPokemonDetailPage> {

  int animatedState = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.pokemon.imageUrl,
                  // ImplicitlyAnimatedWidget
                  /* works only on allowed atributes */
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: animatedState == 0 ? 200 : 400, // animated height prop
                    transformAlignment: Alignment.center,
                    transform: Matrix4.rotationY(animatedState == 0 ? 0 : 1 * math.pi), // animated transform prop
                    curve: Curves.ease, // the rate of change - effects the speed of the animation
                    // curve: Curves.easeInOutQuint,
                    child: Image.network(
                      widget.pokemon.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  right:0,
                  top: 0,
                  // Tween animation builder
                  // works on any type of continuous value that is interpolable (eg. 0 - 1)
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(begin: Colors.transparent, end: animatedState == 0 ? Colors.transparent : Colors.white.withAlpha(1000)),
                    duration: const Duration(milliseconds: 400),
                    builder: (context, color, child) {
                      return ColorFiltered(
                        colorFilter: ColorFilter.mode(color ?? Colors.transparent, BlendMode.modulate),
                        child: child,
                      );
                    },
                    child: Image.network(
                      height: 100,
                      widget.pokemon.imageUrl,
                      width: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TEXT ANIMATION
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    // Animation<double> animation - goes from 0 to 1
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation, 
                        child: child
                      );
                    },
                    child: Text(
                      animatedState == 0 ? widget.pokemon.name : widget.pokemon.name.split('').reversed.join(),
                      key: ValueKey(animatedState),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.pokemon.type,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.pokemon.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        animatedState == 0 ? animatedState = 1 : animatedState = 0;
                      });
                    }, 
                    child: const Text('Animate'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SelectedPokemonProvider>().selectPokemon(widget.pokemon);
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