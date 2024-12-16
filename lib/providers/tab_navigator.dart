import 'package:flutter/material.dart';

class TabNavigatorProvider extends ChangeNotifier {
  int _tabIndex = 0;

  int get tabIndex => _tabIndex;
  
  void setTabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }
}