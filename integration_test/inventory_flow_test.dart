import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:projeto_pi_mobile/main.dart' as app;

void main() {
  // Inicializa o canal de cormunicação com o dispositivo físico
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Módulo de Estoque — Fluxo de Integração E2E (ISO/IEC/IEEE 29119-2)', () {
    
    setUpAll(() async {
      app.main();
    });

    testWidgets('TC01 & TC04 — Fluxo Completo de Cadastro Válido e Stream Realtime', (WidgetTester tester) async {
      // 1. BARREIRA DE INICIALIZAÇÃO DINÂMICA
      // Espera até 10 segundos até o Firebase carregar e a tela inicial real renderizar
      bool appCarregou = false;
      for (int i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 500));
        // Se encontrar qualquer texto comum do seu app ou a barra de navegação, interrompe a espera
        if (find.text('Estoque').evaluate().isNotEmpty || find.byIcon(Icons.inventory).evaluate().isNotEmpty) {
          appCarregou = true;
          break;
        }
      }

      // Se mesmo após 10 segundos o hardware não renderizar, lança um aviso detalhado
      expect(appCarregou, true, reason: 'O aplicativo ficou preso na tela "Test starting..." e não carregou a interface real a tempo.');

      // 2. Navegação para a aba de estoque/inventário de forma resiliente
      final Finder abaInventario = find.byKey(const Key('inventory_nav_btn'));
      if (abaInventario.evaluate().isNotEmpty) {
        await tester.tap(abaInventario.first);
      } else {
        final Finder iconeInventario = find.byIcon(Icons.inventory);
        if (iconeInventario.evaluate().isNotEmpty) {
          await tester.tap(iconeInventario.first);
        } else {
          await tester.tap(find.text('Estoque').first);
        }
      }
      await tester.pump(const Duration(milliseconds: 600));

      // 3. Abre o formulário de cadastro de produtos (+)
      final Finder botaoAdicionar = find.byIcon(Icons.add).first;
      await tester.tap(botaoAdicionar);
      await tester.pump(const Duration(milliseconds: 600));

      // 4. Injeção sequencial segura com base nos TextFields visíveis
      final Finder camposTexto = find.byType(TextField);
      expect(camposTexto, findsAtLeastNWidgets(1), reason: 'Campos de texto do formulário não encontrados.');

      await tester.enterText(camposTexto.at(0), 'Caneca de Cerâmica Branca'); // Nome
      await tester.enterText(camposTexto.at(1), 'Sublimação');                 // Categoria
      await tester.enterText(camposTexto.at(2), '100');                         // Quantidade Atual
      await tester.enterText(camposTexto.at(3), '10');                          // Quantidade Mínima
      await tester.enterText(camposTexto.at(4), '12.50');                       // Preço de Compra
      await tester.enterText(camposTexto.at(5), '35.00');                       // Preço de Venda
      await tester.pump(); 

      // 5. Aciona o salvamento do formulário
      Finder botaoSalvar = find.byKey(const Key('btn_salvar_produto'));
      if (botaoSalvar.evaluate().isEmpty) {
        botaoSalvar = find.text('Salvar');
      }
      if (botaoSalvar.evaluate().isEmpty) {
        botaoSalvar = find.text('Registrar');
      }

      await tester.tap(botaoSalvar.first);
      
      // Janela de tempo para persistência na nuvem real do Firebase Firestore
      await tester.pump(const Duration(seconds: 3));

      // ASSERT (TC01 / TC04) — Confirma se o item reativo aparece na listagem principal
      expect(find.text('Caneca de Cerâmica Branca'), findsOneWidget);
    });

    testWidgets('TC02 — Bloqueio de submissão para campos obrigatórios vazios', (WidgetTester tester) async {
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Força retorno ao formulário se necessário clicando no botão de adicionar (+)
      final Finder botaoAdicionar = find.byIcon(Icons.add);
      if (botaoAdicionar.evaluate().isNotEmpty) {
        await tester.tap(botaoAdicionar.first);
        await tester.pump(const Duration(milliseconds: 600));
      }

      // Preenche apenas um campo de texto simulando entrada inválida/incompleta
      final Finder camposTexto = find.byType(TextField);
      await tester.enterText(camposTexto.first, 'Camiseta Poliéster');
      await tester.pump();

      // Envia os dados incompletos
      Finder botaoSalvar = find.byKey(const Key('btn_salvar_produto'));
      if (botaoSalvar.evaluate().isEmpty) {
        botaoSalvar = find.text('Salvar');
      }
      if (botaoSalvar.evaluate().isEmpty) {
        botaoSalvar = find.text('Registrar');
      }

      await tester.tap(botaoSalvar.first);
      await tester.pump(const Duration(milliseconds: 600));

      // ASSERT — Captura se o sistema barrou a operação através do feedback visual mapeado
      final erroVisivel = find.text('Preencha todos os campos obrigatórios').evaluate().isNotEmpty;
      final snackBarVisivel = find.byType(SnackBar).evaluate().isNotEmpty;
      
      expect(erroVisivel || snackBarVisivel, true, 
          reason: 'O aplicativo deveria apresentar uma mensagem contendo o alerta de campos obrigatórios.');
    });
  });
}