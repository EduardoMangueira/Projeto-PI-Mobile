import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inventory/viewmodel/inventory_viewmodel.dart';

// PÁGINA DE NOTIFICAÇÕES E ALERTAS DO ESTOQUE
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inventoryVm = context.watch<InventoryViewModel>();
    final produtosCriticos = inventoryVm.produtos.where((p) => p.estoqueCritico).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF08080C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF14121C),
        elevation: 0,
        title: const Text(
          'Alertas de Estoque',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: produtosCriticos.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green, size: 64),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum alerta pendente!',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Todos os seus insumos estão abastecidos.',
                    style: TextStyle(color: Color(0xFF7A6A9A), fontSize: 12),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: produtosCriticos.length,
              itemBuilder: (context, index) {
                final produto = produtosCriticos[index];
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF14121C),
                    border: Border.all(color: const Color(0xFFD32F2F)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFF2C1414),
                        child: Icon(Icons.assignment_late_outlined, color: Color(0xFFE57373)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              produto.nome,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Categoria: ${produto.categoria}',
                              style: const TextStyle(color: Color(0xFF7A6A9A), fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${produto.quantidadeAtual} itens',
                            style: const TextStyle(
                              color: Color(0xFFE57373),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Mínimo: ${produto.estoqueMinimo}',
                            style: const TextStyle(color: Color(0xFF7A6A9A), fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}