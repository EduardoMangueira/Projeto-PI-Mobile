import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../inventory/viewmodel/inventory_viewmodel.dart';
import '../viewmodel/home_viewmodel.dart';
import '../../notifications/viewmodel/notifications_viewmodel.dart';
import 'package:projeto_pi_mobile/app/routes/app_routes.dart';
import '../../sales/viewmodel/sales_viewmodel.dart';
import '../../sales/model/sales_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final salesVm = context.watch<SalesViewModel>();
    final produtosCriticos = context
        .watch<InventoryViewModel>()
        .produtos
        .where((p) => p.estoqueCritico)
        .toList();
    final notifVm = context.watch<NotificationsViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF08080C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09080D),
        elevation: 0,
        title: Text(
          'StockFinance',
          style: GoogleFonts.aoboshiOne(
            color: const Color(0xFFBB4FCF),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.notifications),
              ),
              if (notifVm.naoLidas > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF2D1B4E),
              child: Icon(Icons.person, color: Color(0xFF7A6A9A), size: 18),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _cardFinanceiro(
                    'LUCRO LÍQUIDO',
                    'R\$ ${salesVm.lucroLiquido.toStringAsFixed(2)}',
                    'Margem: ${salesVm.margemLucro.toStringAsFixed(1)}%',
                    Colors.greenAccent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _cardFinanceiro(
                    'RECEITA TOTAL',
                    'R\$ ${salesVm.receitaTotal.toStringAsFixed(2)}',
                    'Despesas: ${salesVm.percentualDespesas.toStringAsFixed(1)}%',
                    Colors.redAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _cardAlerta(context),
            const SizedBox(height: 14),
            _cardGrafico(salesVm),
            const SizedBox(height: 14),
            Text(
              'Últimas Movimentações',
              style: GoogleFonts.aoboshiOne(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            ...salesVm.ultimasMovimentacoes.map((m) => _tileMovimentacao(m)),
          ],
        ),
      ),
    );
  }

  Widget _cardFinanceiro(
    String titulo,
    String valor,
    String sub,
    Color? subColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF5000BF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(color: Color(0xFFBDBABA), fontSize: 10),
          ),
          const SizedBox(height: 4),
          Text(
            valor,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: TextStyle(
              color: subColor ?? const Color(0xFF7A6A9A),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardAlerta(BuildContext context) {
    final inventoryVm = context.watch<InventoryViewModel>();
    final produtosCriticos = inventoryVm.produtos
        .where((p) => p.estoqueCritico)
        .toList();
    final quantidade = produtosCriticos.length;

    if (quantidade == 0) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF14121C),
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estoque Abastecido',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Tudo sob controle',
                    style: TextStyle(color: Color(0xFF7A6A9A), fontSize: 10),
                  ),
                ],
              ),
            ),
            Text(
              '0 alertas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF14121C),
        border: Border.all(color: const Color(0xFFF1C21B)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFF1C31B),
            size: 20,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Atenção: Estoque Baixo',
                  style: TextStyle(
                    color: Color(0xFFF1C21B),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Requer reposição',
                  style: TextStyle(color: Color(0xFF7A6A9A), fontSize: 10),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
            child: const Text(
              'Ver todos',
              style: TextStyle(color: Color(0xFFF1C21B), fontSize: 11),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$quantidade itens',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardGrafico(SalesViewModel salesVm) {
    final dados = salesVm.dadosDoGrafico;
    
    double tetoMaximo = 1000.0;
    for (var m in dados) {
      if ((m['receita'] as double) > tetoMaximo) tetoMaximo = m['receita'] as double;
      if ((m['despesa'] as double) > tetoMaximo) tetoMaximo = m['despesa'] as double;
    }
    tetoMaximo = tetoMaximo * 1.1; 

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1845),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RECEITA VS DESPESAS',
            style: TextStyle(
              color: Color(0xFF7A6A9A),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: dados.map((m) {
                final hR = (m['receita'] as double) / tetoMaximo * 70;
                final hD = (m['despesa'] as double) / tetoMaximo * 70;
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 16,
                          height: hR > 0 ? hR : 2,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF5000BF), Color(0xFFAE00FF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 3),
                        Container(
                          width: 16,
                          height: hD > 0 ? hD : 2,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3D2560),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      m['mes'] as String,
                      style: const TextStyle(
                        color: Color(0xFF7A6A9A),
                        fontSize: 10,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tileMovimentacao(SalesModel m) {
    final isVenda = m.tipo == TipoMov.venda;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF14121C),
        border: Border.all(color: const Color(0xFF313131)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: isVenda
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              border: Border.all(
                color: isVenda ? Colors.green : Colors.red,
                width: 1.5,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isVenda ? Icons.arrow_upward : Icons.arrow_downward,
              color: isVenda ? Colors.green : Colors.red,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${m.quantidade}x ${m.item}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                Text(
                  m.data,
                  style: const TextStyle(
                    color: Color(0xFF7A6A9A),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'R\$ ${m.valor.abs().toStringAsFixed(2)}',
            style: TextStyle(
              color: isVenda ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
