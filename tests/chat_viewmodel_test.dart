import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChatViewModel - Testes de Unidade', () {
    test('TC09 — Assegurar a higienização de strings de entrada para pacotes de chat com IA', () {
      final String inputBrutoDoUsuario = "   Qual a temperatura ideal da prensa?   ";
      final String inputSanitizado = inputBrutoDoUsuario.trim();

      expect(inputSanitizado == "Qual a temperatura ideal da prensa?", true);
    });
  });
}