import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../data/usuario_mock_store.dart';

class CadastroViewModel {
  
  Future<bool> cadastrar(String email, String senha, String usuario, String telefone) async {
    if (email.isEmpty || senha.isEmpty || usuario.isEmpty || telefone.isEmpty) {
      return false; 
    }

    // tempo de carregamento
    await Future.delayed(const Duration(seconds: 1));

    // Cria um usuario com os dados digitados
    final novoUsuario = UsuarioModel(
      email: email,
      senha: senha,
      nomeUsuario: usuario,
      telefone: telefone,
    );

    // 2. Salva no "banco de dados"
    UsuarioMockStore().adicionarUsuario(novoUsuario);

    return true; 
  }
}