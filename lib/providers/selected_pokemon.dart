import 'package:flutter/material.dart';
import 'package:flutter_template/models/pokemon.dart';

class SelectedPokemonProvider extends ChangeNotifier{
  Pokemon? _selectedPokemon;

  Pokemon? get selectedPokemon => _selectedPokemon;

  void selectPokemon(Pokemon pokemon){
    _selectedPokemon = pokemon;
    notifyListeners();
  }
}