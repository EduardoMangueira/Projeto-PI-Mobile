import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Agora usamos Mapas para rastrear o status de CADA e-mail individualmente
  final Map<String, int> _tentativasPorUsuario = {};
  final Map<String, DateTime> _bloqueiosPorUsuario = {};

  Future<String?> fazerLogin(String usuario, String senha) async {
    // Padronizamos o e-mail para minúsculas para não haver confusão
    final emailFormatado = usuario.trim().toLowerCase();

    //Verifica se ESTA CONTA ESPECÍFICA está bloqueada neste momento
    if (_bloqueiosPorUsuario.containsKey(emailFormatado)) {
      final bloqueadoAte = _bloqueiosPorUsuario[emailFormatado]!;
      
      if (DateTime.now().isBefore(bloqueadoAte)) {
        final minutosRestantes = bloqueadoAte.difference(DateTime.now()).inMinutes;
        final segundosRestantes = bloqueadoAte.difference(DateTime.now()).inSeconds % 60;
        return 'Conta bloqueada. Tente novamente em ${minutosRestantes}m ${segundosRestantes}s.';
      } else {
        // O tempo de bloqueio já passou, podemos libertar a conta
        _bloqueiosPorUsuario.remove(emailFormatado);
        _tentativasPorUsuario.remove(emailFormatado);
      }
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: emailFormatado,
        password: senha.trim(),
      );
      
      //Sucesso: Limpa o histórico de falhas APENAS deste usuário
      _tentativasPorUsuario.remove(emailFormatado);
      _bloqueiosPorUsuario.remove(emailFormatado);
      return null; 
      
    } on FirebaseAuthException catch (e) {
      debugPrint('Erro no Firebase: ${e.code}');
      return _registrarFalha(emailFormatado);
    } catch (e) {
      return _registrarFalha(emailFormatado);
    }
  }

  // Função auxiliar que agora recebe o e-mail para saber quem falhou
  String _registrarFalha(String email) {
    // Pega as tentativas atuais do usuário ou começa do 0
    final tentativasAtuais = _tentativasPorUsuario[email] ?? 0;
    final novasTentativas = tentativasAtuais + 1;
    
    // Atualiza o mapa com o novo número de falhas
    _tentativasPorUsuario[email] = novasTentativas;
    
    if (novasTentativas >= 5) {
      // Bloqueia ESTE e-mail por 5 minutos a partir de agora
      _bloqueiosPorUsuario[email] = DateTime.now().add(const Duration(minutes: 5));
      return 'Conta bloqueada por 5 minutos devido a múltiplas tentativas falhadas.';
    }
    
    final tentativasRestantes = 5 - novasTentativas;
    return 'Usuário ou senha incorretos. Restam $tentativasRestantes tentativa(s).';
  }

  void irParaCadastro(BuildContext context) {
    Navigator.pushNamed(context, '/signup');
  }
}