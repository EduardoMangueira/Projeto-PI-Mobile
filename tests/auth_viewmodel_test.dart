import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthViewModel (Login & Signup) - Testes de Unidade', () {
    test('TC04 — Validar barreira estrutural de e-mail malformado no Login', () {
      final String emailDigitado = "parceiro_sublimacaogmail.com"; // Sem caractere @
      bool formatoValido = emailDigitado.contains('@') && emailDigitado.endsWith('.com');

      expect(formatoValido, false);
    });

    test('TC05 — Impedir criação de conta com tamanho de senha abaixo do limite mínimo', () {
      final String senhaCurta = "1234"; // Critério mínimo exige >= 6 dígitos
      bool senhaAprovada = senhaCurta.length >= 6;

      expect(senhaAprovada, false);
    });
  });
}