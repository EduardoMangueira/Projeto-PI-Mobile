import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// VIEWMODEL ENCARREGADO DA VALIDAÇÃO DE ACESSO E ROTAS INICIAIS
class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // VALIDA AS CREDENCIAIS DO USUÁRIO JUNTO AO SERVIDOR DO FIREBASE
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

  // ENCAMINHA O FLUXO DO USUÁRIO PARA A TELA DE REGISTRO DE CONTA
  void irParaCadastro(BuildContext context) {
    Navigator.pushNamed(context, '/signup');
  }
}