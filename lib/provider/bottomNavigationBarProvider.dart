import 'package:flutter/material.dart';

class ButtonNavigationBarProvider extends ChangeNotifier {
  int _screenIndex = 0; // Initial index of the screen
  
  // return the current screen Index
  int get screenIndex => _screenIndex;

  //update the screenIndex
  set currentIndex(int index) {
    _screenIndex = index;
    notifyListeners();
  }
}