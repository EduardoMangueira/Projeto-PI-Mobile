import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// VIEWMODEL PARA CADASTRO DE NOVO USUÁRIO
class SignupViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // REALIZA O REGISTRO ASSÍNCRONO, VINCULANDO O NOME DE USUÁRIO AO PERFIL CRIADO 
  Future<bool> fazerCadastro(String nome, String email, String senha) async {
    try {
      //cria a conta com email e senha no Firebase Auth
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