import 'package:flutter/material.dart';
import '../views/cadastro_view.dart'; 
import '../data/usuario_mock_store.dart';

class LoginViewModel {
  
  Future<bool> fazerLogin(String usuario, String senha) async {
    if (usuario.isEmpty || senha.isEmpty) {
      return false; 
    }
    // tempo de carregamento
    await Future.delayed(const Duration(seconds: 1));
    // Verifica no mock se o que foi colocado está cadastrado
    return UsuarioMockStore().verificarLogin(usuario, senha);
  }

  void recuperarSenha(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Redirecionando para recuperação de senha...')),
    );
  }

  void irParaCadastro(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaCadastro()),
    );
  }
}