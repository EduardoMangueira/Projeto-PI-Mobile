import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:projeto_pi_mobile/main.dart' as app;

void main() {
  // Inicialização obrigatória do vínculo para execução de testes de integração reais
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Testes de Integração Ponta a Ponta - Módulo de Estoque (Inventory)', () {
    
    testWidgets('TC01 - Cadastro de insumo completo e válido com persistência', (WidgetTester tester) async {
      // Inicializa a aplicação conectada ao Firebase de teste
      app.main();
      await tester.pumpAndSettle();

      // Navega até a tela de inventário/estoque
      final Finder inventoryTab = find.byKey(const Key('inventory_nav_btn'));
      await tester.tap(inventoryTab);
      await tester.pumpAndSettle();

      // Toca no botão para abrir o formulário de novo produto
      final Finder addProductFab = find.byKey(const Key('add_product_fab'));
      await tester.tap(addProductFab);
      await tester.pumpAndSettle();

      // Injeta os dados válidos respeitando os 6 atributos obrigatórios do RF01
      await tester.enterText(find.byKey(const Key('input_nome')), 'Caneca de Cerâmica Branca');
      await tester.enterText(find.byKey(const Key('input_categoria')), 'Sublimação');
      await tester.enterText(find.byKey(const Key('input_qtd_atual')), '100');
      await tester.enterText(find.byKey(const Key('input_qtd_minima')), '10');
      await tester.enterText(find.byKey(const Key('input_preco_compra')), '12.50');
      await tester.enterText(find.byKey(const Key('input_preco_venda')), '35.00');
      await tester.pumpAndSettle();

      // Dispara a ação de salvamento
      final Finder saveButton = find.byKey(const Key('btn_salvar_produto'));
      await tester.tap(saveButton);
      
      // Aguarda o processamento da requisição de rede e retorno da navegação
      await tester.pumpAndSettle();

      // Asserção: Verifica se o produto foi salvo e consta na listagem atualizada via Stream
      expect(find.text('Caneca de Cerâmica Branca'), findsOneWidget);
    });

    testWidgets('TC02 - Cadastro com omissão de campos obrigatórios (Bloqueio Local)', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navega e abre o formulário
      await tester.tap(find.byKey(const Key('inventory_nav_btn')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('add_product_fab')));
      await tester.pumpAndSettle();

      // Preenche apenas alguns campos, deixando outros obrigatórios vazios
      await tester.enterText(find.byKey(const Key('input_nome')), 'Camiseta Poliéster');
      await tester.enterText(find.byKey(const Key('input_categoria')), 'Vestuário');
      await tester.enterText(find.byKey(const Key('input_qtd_atual')), '50');
      // Quantidade mínima, preço de compra e preço de venda deixados em branco
      await tester.pumpAndSettle();

      // Tenta salvar o formulário incompleto
      await tester.tap(find.byKey(const Key('btn_salvar_produto')));
      await tester.pumpAndSettle();

      // Asserção: O app deve exibir a mensagem de erro em um SnackBar ou componente de alerta
      expect(find.text('Preencha todos os campos obrigatórios'), findsOneWidget);
    });

    testWidgets('TC03 - Baixa de estoque além do limite (Impedir Estoque Negativo)', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Acessa a página de inventário
      await tester.tap(find.byKey(const Key('inventory_nav_btn')));
      await tester.pumpAndSettle();

      // Tenta acionar uma redução de estoque drástica usando botões de ajuste rápido
      // Supondo um item com quantidade menor do que o decremento solicitado
      final Finder decrementBtn = find.byKey(const Key('btn_decrementar_lote')).first;
      await tester.tap(decrementBtn);
      await tester.pumpAndSettle();

      // Asserção: Garante o bloqueio visual e impede atualização inválida
      expect(find.text('Estoque insuficiente'), findsOneWidget);
    });
  });
}
