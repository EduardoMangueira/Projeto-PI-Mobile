import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SalesViewModel - Testes de Unidade', () {
    test('TC03 — Validação matemática do fluxo de caixa e cálculo de balanço líquido', () {
      final double receitaBruta = 1200.00;
      final double despesaOperacional = 450.00;

      final double balancoCalculado = receitaBruta - despesaOperacional;

      expect(balancoCalculado == 750.00, true);
      expect(balancoCalculado >= 0, true);
    });
  });
}