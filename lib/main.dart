import 'package:flutter/material.dart';
import 'package:flutter_template/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_template/providers/counter.dart';
import 'package:flutter_template/providers/tab_navigator.dart';
import 'package:flutter_template/providers/selected_pokemon.dart';
import 'package:provider/provider.dart';
import 'package:flutter_template/routes.dart';

final getIt = GetIt.instance;
void setup() {
  getIt.registerSingleton<CounterProvider>(CounterProvider());
  getIt.registerSingleton<TabNavigatorProvider>(TabNavigatorProvider());

}

void main() {
  setup();
  runApp(
    // use get_it with provider
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterProvider>.value(value: getIt<CounterProvider >()),
        ChangeNotifierProvider<TabNavigatorProvider>.value(value: getIt<TabNavigatorProvider>()),
        ChangeNotifierProvider<SelectedPokemonProvider>(create: (_) => SelectedPokemonProvider()),
      ], 
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'OneForty',
      // locale: provider.locale,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}