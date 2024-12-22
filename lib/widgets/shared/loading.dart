
import 'package:flutter/material.dart';

class PokeballLoadingWidget extends StatefulWidget {
  const PokeballLoadingWidget({super.key});

  @override
  State<PokeballLoadingWidget> createState() => _PokeballLoadingWidgetState();
}

class _PokeballLoadingWidgetState extends State<PokeballLoadingWidget> with SingleTickerProviderStateMixin{
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