import '../models/usuario_model.dart';

class UsuarioMockStore {
  static final UsuarioMockStore _instancia = UsuarioMockStore._interno();
  factory UsuarioMockStore() => _instancia;
  UsuarioMockStore._interno();

  // "Banco de dados"
  final List<UsuarioModel> _usuarios = [
    UsuarioModel(
      nomeUsuario: 'teste',
      email: 'teste@teste.com',
      senha: '1234',
      telefone: '99999999999',
    ),
  ];

  // salvar um novo usuário
  void adicionarUsuario(UsuarioModel usuario) {
    _usuarios.add(usuario);
    print("Usuário cadastrado com sucesso! Total de usuários: ${_usuarios.length}");
  }

  //login é válido
  bool verificarLogin(String usuarioOuEmail, String senha) {
    return _usuarios.any((u) => 
      // Verifica se o texto digitado bate com o email OU com o nome de usuário
      (u.nomeUsuario == usuarioOuEmail || u.email == usuarioOuEmail) && 
      u.senha == senha
    );
  }
}