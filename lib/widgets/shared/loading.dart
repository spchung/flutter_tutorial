
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PokeballLoadingWidgetV1 extends StatefulWidget {
  const PokeballLoadingWidgetV1({super.key});

  @override
  State<PokeballLoadingWidgetV1> createState() => _PokeballLoadingWidgetV1State();
}

class _PokeballLoadingWidgetV1State extends State<PokeballLoadingWidgetV1> with SingleTickerProviderStateMixin{
  late final AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.repeat(reverse: false);
  } 

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * 3.141592653589793,
              child: Icon(
                Icons.catching_pokemon,
                size: 100,
                color: Colors.grey[400],
              ),
            );
          },
        )
      ),
    );
  }
}

// This is the same as the above widget but using TweenAnimationBuilder
class PokeballLoadingWidget extends StatelessWidget {
  const PokeballLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 10),
          builder: (context, double value, child) {
            return Transform.rotate(
              angle: value * 30 * math.pi, // scale the constant against the duration
              child: Icon(
                Icons.catching_pokemon,
                size: 100,
                color: Colors.grey[400],
              ),
            );
          },
        ),
      ),
    );
  }
}

class PokeballIcon extends StatelessWidget {
  const PokeballIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.catching_pokemon,
      size: 100,
      color: Colors.grey[400],
    );
  }
}