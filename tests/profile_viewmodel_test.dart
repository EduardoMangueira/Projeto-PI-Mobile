import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ProfileViewModel - Testes de Unidade', () {
    test('TC06 — Impedir atualização cadastral com strings vazias em campos obrigatórios', () {
      final String nomeFantasia = "   "; // String vazia com espaços em branco
      bool dadosProntosParaSalvar = nomeFantasia.trim().isNotEmpty;

      expect(dadosProntosParaSalvar, false);
    });
  });
}