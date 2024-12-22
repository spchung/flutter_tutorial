import 'package:flutter_template/widgets/shared/loading.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/widgets/home/navigator.dart';
import 'package:flutter_template/widgets/pokemons/pokemons_api.dart';

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
            // return const PokemonsPage();
            return const PokemonsApiPage();
          },
        ),
        GoRoute(
          path: '/test',
          builder: (context, state) {
            return PokeballLoadingWidget();
          },
        )
      ]
    ),
  ],
);