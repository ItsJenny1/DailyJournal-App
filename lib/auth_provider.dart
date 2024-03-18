import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _loggedInUser = '';

  bool get isLoggedIn => _isLoggedIn;

  String get loggedInUser => _loggedInUser;

  
  Future<void> signUp(String email, String password) async {
    
    await Future.delayed(Duration(seconds: 2));
    
    
    if (email.isNotEmpty && password.isNotEmpty) {
     
      _isLoggedIn = true;
      _loggedInUser = email;
      notifyListeners();
    } else {
      
      throw Exception('Invalid email or password');
    }
  }

  
  Future<void> signIn(String email, String password) async {
    
    await Future.delayed(Duration(seconds: 2));
    
    
    if (email == 'user@example.com' && password == 'password') {
     
      _isLoggedIn = true;
      _loggedInUser = email;
      notifyListeners();
    } else {
      
      throw Exception('Invalid email or password');
    }
  }

 
  void signOut() {
    _isLoggedIn = false;
    _loggedInUser = '';
    notifyListeners();
  }
}
