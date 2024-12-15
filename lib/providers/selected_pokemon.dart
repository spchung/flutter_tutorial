import 'package:flutter/material.dart';
import 'package:flutter_template/models/pokemon.dart';

class SelectedPokemonProvider extends ChangeNotifier{
  PokemonModel? _selectedPokemon;
  bool selected = false;

  PokemonModel? get selectedPokemon => _selectedPokemon;
  bool get hasSelectedPokemon => selected;

  void selectPokemon(PokemonModel pokemon){
    selected = true;
    _selectedPokemon = pokemon;
    notifyListeners();
  }
}