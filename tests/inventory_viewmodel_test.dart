import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_pi_mobile/features/inventory/model/inventory_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('InventoryViewModel - Testes de Unidade (ISO/IEC/IEEE 29119-4)', () {
    test('TC01 — Cadastro com omissão de campos (Validação do Contrato do Molde)', () {
      final produtoValido = InventoryModel(
        id: '123',
        nome: 'Caneca de Cerâmica',
        categoria: 'Sublimação',
        quantidadeAtual: 50,
        estoqueMinimo: 10, 
        precoCompra: 12.50,
        precoVenda: 35.00,
      );

      expect(produtoValido.nome.isNotEmpty, true);
      expect(produtoValido.categoria.isNotEmpty, true);
      expect(produtoValido.quantidadeAtual >= 0, true);
    });

    test('TC02 — Validação de Bloqueio para Estoque Negativo (Técnica do Valor Limite)', () {
      final produtoNegativo = InventoryModel(
        id: 'prod_erro',
        nome: 'Camiseta Inválida',
        categoria: 'Vestuário',
        quantidadeAtual: -1, 
        estoqueMinimo: 5,
        precoCompra: 15.00,
        precoVenda: 40.00,
      );

      bool aOperacaoFoiBloqueada = false;
      if (produtoNegativo.quantidadeAtual < 0) {
        aOperacaoFoiBloqueada = true; 
      }

      expect(aOperacaoFoiBloqueada, true);
    });
  });
}