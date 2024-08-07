import 'package:flutter/material.dart';

class MyActiveProvider extends ChangeNotifier {
  // Default value
  bool _isMenuActive =
      false;
  bool _isServiceDeployed = false;

  // Getter
  bool get isMenuActive => _isMenuActive;
  bool get isServiceDeployed => _isServiceDeployed;

  // Updater
  void setIsMenuActive(bool newValue) {
    _isMenuActive = newValue;
    notifyListeners();
  }

  void setIsServiceDeployed(bool newValue) {
    _isServiceDeployed = newValue;
    notifyListeners();
  }
}
