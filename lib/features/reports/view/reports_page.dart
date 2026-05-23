import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../shared/view/stock_app_bar.dart';
import '../../sales/viewmodel/sales_viewmodel.dart';
import '../../inventory/viewmodel/inventory_viewmodel.dart';

// TELA DE RELATÓRIOS COM ANÁLISES FINANCEIRAS
class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final salesVm = context.watch<SalesViewModel>();
    final invVm = context.watch<InventoryViewModel>();

    //CÁLCULOS DO LUCRO TOTAL
    final lucroTotal = salesVm.lucroLiquido;
    final variacao = salesVm.margemLucro > 0 ? (salesVm.margemLucro / 2) : 0.0;

    int totalItensEstoque = invVm.produtos.fold(0, (sum, item) => sum + item.quantidadeAtual);
    
    double valorInvestidoEstoque = invVm.produtos.fold(
      0.0, (sum, item) => sum + (item.quantidadeAtual * item.precoCompra)
    );
    
    double lucroProjetado = invVm.produtos.fold(
      0.0, (sum, item) => sum + (item.quantidadeAtual * (item.precoVenda - item.precoCompra))
    );

    List<Map<String, String>> insightsGerados = [];
    
    final produtosAvisos = invVm.produtos.where((p) => p.estoqueCritico).toList();
    if (produtosAvisos.isNotEmpty) {
      insightsGerados.add({
        'titulo': 'ALERTA DE RUPTURA',
        'descricao': 'Você tem ${produtosAvisos.length} produtos prestes a esgotar. Reponha o estoque para não perder vendas nesta semana.'
      });
    } else {
      insightsGerados.add({
        'titulo': 'ESTOQUE SAUDÁVEL',
        'descricao': 'Nenhum produto em nível crítico. Seu estoque está perfeitamente balanceado para a demanda atual.'
      });
    }

    if (salesVm.margemLucro > 30) {
      insightsGerados.add({
        'titulo': 'ALTA RENTABILIDADE',
        'descricao': 'Sua margem de lucro atual é de ${salesVm.margemLucro.toStringAsFixed(1)}%. Excelente desempenho comercial nas vendas recentes!'
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFF08080C),
      appBar: const StockAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Relatórios',
              style: GoogleFonts.anekBangla(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF5000BF), Color(0xFFAE00FF)],
                ),          
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Lucro Total Líquido',
                    style: GoogleFonts.aoboshiOne (color: const Color(0xFFBDBABA), fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'R\$ ${lucroTotal.toStringAsFixed(2)}',
                    style: GoogleFonts.aoboshiOne(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(variacao >= 0 ? Icons.trending_up : Icons.trending_down, 
                          color: variacao >= 0 ? Colors.green : Colors.redAccent, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${variacao >= 0 ? '+' : ''}${variacao.toStringAsFixed(2)}% de margem',
                        style: GoogleFonts.aoboshiOne(
                            color: variacao >= 0 ? Colors.green : Colors.redAccent, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
             Text(
              'Visão Geral do Estoque',
              style: GoogleFonts.aoboshiOne(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            
            _buildInfoCard(
              'Capital Empatado (Custo do Estoque)', 
              'R\$ ${valorInvestidoEstoque.toStringAsFixed(2)}', 
              Icons.inventory_2, 
              const Color(0xFFBB4FCF)
            ),
            const SizedBox(height: 12),
            
            _buildInfoCard(
              'Lucro Projetado (Se vender tudo)', 
              'R\$ ${lucroProjetado.toStringAsFixed(2)}', 
              Icons.trending_up, 
              Colors.greenAccent
            ),
            const SizedBox(height: 12),
            
            _buildInfoCard(
              'Volume Total Guardado', 
              '$totalItensEstoque unidades', 
              Icons.widgets, 
              Colors.blueAccent
            ),
            const SizedBox(height: 24),
            
            //
            Text(
              'Análise Preditiva IA',
              style: GoogleFonts.aoboshiOne(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            
            ...insightsGerados.map(
              (insight) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF14121C),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFAE00FF),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF5000BF), Color(0xFFAE00FF)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            insight['titulo']!,
                            style: GoogleFonts.aoboshiOne(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            insight['descricao']!,
                            style: GoogleFonts.aoboshiOne(
                              color: const Color(0xFFB0A0C8),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //CARTÕES DO ESTOQUE
  Widget _buildInfoCard(String title, String value, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1845),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, 
                  style: GoogleFonts.aoboshiOne(color: const Color(0xFF7A6A9A), fontSize: 11)
                ),
                const SizedBox(height: 4),
                Text(
                  value, 
                  style: GoogleFonts.aoboshiOne(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}