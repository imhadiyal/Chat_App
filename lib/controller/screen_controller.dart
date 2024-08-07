import 'package:flutter/material.dart';

class ScreenController extends ChangeNotifier {
  int screenIndex = 0;

  int get CurrentScreenIndex => screenIndex;

  void updateScreenIndex(int newIndex) {
    screenIndex = newIndex;
    notifyListeners();
  }
}
