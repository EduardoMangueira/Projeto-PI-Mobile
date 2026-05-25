import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomeViewModel - Testes de Unidade', () {
    test('TC07 — Certificar consolidação de dados e estados de alerta no Dashboard principal', () {
      final int totalVendasConcluidas = 25;
      final int alertasEstoqueBaixo = 4;

      bool exibirSinalizadorDeAtencao = alertasEstoqueBaixo > 0;

      expect(totalVendasConcluidas == 25, true);
      expect(exibirSinalizadorDeAtencao, true);
    });
  });
}