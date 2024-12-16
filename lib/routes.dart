import 'package:go_router/go_router.dart';
import 'package:flutter_template/widgets/home/navigator.dart';
import 'package:flutter_template/widgets/pokemons/pokemons.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeNavigator();
      },
      routes:[
        GoRoute(
          path: '/pokemons',
          builder: (context, state) {
            return const PokemonsPage();
          },
        ),
      ]
    ),
  ],
);