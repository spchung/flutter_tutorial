import 'package:flutter/material.dart';
import 'package:flutter_template/models/pokemon.dart';

class SelectedPokemonProvider extends ChangeNotifier{
  PokemonModel? _selectedPokemon;

  PokemonModel? get selectedPokemon => _selectedPokemon;

  void selectPokemon(PokemonModel pokemon){
    _selectedPokemon = pokemon;
    notifyListeners();
  }
}