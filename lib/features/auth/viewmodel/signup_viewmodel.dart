import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> fazerCadastro(String nome, String email, String senha) async {
    try {
      //O Firebase cria a conta com email e senha
      UserCredential credencial = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: senha.trim(),
      );

      await credencial.user?.updateDisplayName(nome.trim());
      
      return true;
      
    } catch (e) {
      debugPrint('Erro ao cadastrar no Firebase: $e');
      return false;
    }
  }
}