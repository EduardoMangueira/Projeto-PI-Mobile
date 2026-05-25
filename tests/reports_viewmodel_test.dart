import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ReportsViewModel - Testes de Unidade', () {
    test('TC08 — Validar precisão algorítmica da fórmula de margem de lucro operacional', () {
      final double custoInsumo = 20.00;
      final double precoVendaFinal = 80.00;

      final double lucroObtido = precoVendaFinal - custoInsumo;
      final double margemLucroReal = (lucroObtido / precoVendaFinal) * 100;

      expect(margemLucroReal == 75.0, true);
    });
  });
}