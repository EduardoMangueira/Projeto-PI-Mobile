import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> fazerLogin(String usuario, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: usuario.trim(),
        password: senha.trim(),
      );
      return true; 
      
    } on FirebaseAuthException catch (e) {
      debugPrint('Erro no Firebase: ${e.code}');
      return false; 
    } catch (e) {
      return false;
    }
  }
  void irParaCadastro(BuildContext context) {
    Navigator.pushNamed(context, '/signup');
  }
}