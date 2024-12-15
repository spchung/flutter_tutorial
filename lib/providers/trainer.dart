import 'package:flutter/material.dart';
import 'package:flutter_template/models/trainer.dart';

class TrainerProvider extends ChangeNotifier {
  TrainerModel? _trainer;

  TrainerModel? get trainer => _trainer;

  void setTrainer(TrainerModel trainer) {
    _trainer = trainer;
    notifyListeners();
  }
}
