import 'package:flutter/material.dart';
import '../../views/login_view.dart'; 

class SplashViewModel {
  void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TelaLogin()),
    );
  }
}