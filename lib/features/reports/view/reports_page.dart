import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../shared/view/stock_app_bar.dart';
import '../viewmodel/reports_viewmodel.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ReportsViewModel>();

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
                    'Lucro Total',
                    style: GoogleFonts.aoboshiOne (color: const Color(0xFFBDBABA), fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'R\$ ${vm.lucroTotal.toStringAsFixed(2)}',
                    style: GoogleFonts.aoboshiOne(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.trending_up, color: Colors.green, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '+${vm.variacao.toStringAsFixed(2)}% vs. mês anterior',
                        style: GoogleFonts.aoboshiOne(color: Colors.green, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
             Text(
              'Desempenho Mensal',
              style: GoogleFonts.aoboshiOne(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF2A1845),
                borderRadius: BorderRadius.circular(14),
              ),
              child: SizedBox(
                height: 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: vm.desempenho.map((d) {
                    final h = (d['valor'] as double) / 4000 * 80;
                    final isCurrent = d['mes'] == 'Mar';
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 26,
                          height: h,
                          decoration: BoxDecoration(
                            gradient: isCurrent
                                ? const LinearGradient(
                                    colors: [Color(0xFF5000BF), Color(0xFFAE00FF)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  )
                                : null,
                            color: isCurrent ? null : const Color(0xFF3D2560),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          d['mes'] as String,
                          style: GoogleFonts.aoboshiOne(
                            color: const Color(0xFF7A6A9A),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Análise Preditiva IA',
              style: GoogleFonts.aoboshiOne(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            ...vm.insights.map(
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
}