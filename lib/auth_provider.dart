import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _loggedInUser = '';

  bool get isLoggedIn => _isLoggedIn;

  String get loggedInUser => _loggedInUser;

  // Method to sign up a user
  Future<void> signUp(String email, String password) async {
    // Simulating sign-up process with a delay
    await Future.delayed(Duration(seconds: 2));
    
    // Simulated validation: email and password should not be empty
    if (email.isNotEmpty && password.isNotEmpty) {
      // Simulated successful sign-up
      _isLoggedIn = true;
      _loggedInUser = email;
      notifyListeners();
    } else {
      // Simulated sign-up failure
      throw Exception('Invalid email or password');
    }
  }

  // Method to sign in a user
  Future<void> signIn(String email, String password) async {
    // Simulating sign-in process with a delay
    await Future.delayed(Duration(seconds: 2));
    
    // Simulated validation: email and password should match a predefined combination
    if (email == 'user@example.com' && password == 'password') {
      // Simulated successful sign-in
      _isLoggedIn = true;
      _loggedInUser = email;
      notifyListeners();
    } else {
      // Simulated sign-in failure
      throw Exception('Invalid email or password');
    }
  }

  // Method to sign out a user
  void signOut() {
    _isLoggedIn = false;
    _loggedInUser = '';
    notifyListeners();
  }
}
