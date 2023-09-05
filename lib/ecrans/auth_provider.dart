import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  void login() {
    // Ajoutez ici la logique de connexion
    _isConnected = true;
    notifyListeners(); // Notifie les écouteurs que l'état a changé
  }

  void logout() {
    // Ajoutez ici la logique de déconnexion
    _isConnected = false;
    notifyListeners();
  }
}
