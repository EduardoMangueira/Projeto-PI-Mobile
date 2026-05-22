import 'package:flutter/material.dart';
import '../../home/view/home_page.dart';
import '../../inventory/view/inventory_page.dart';
import '../../chat/view/chat_page.dart';
import '../../sales/view/sales_page.dart';
import '../../reports/view/reports_page.dart';

// COMPONENTE SHELL QUE SERVE DE BASE PARA A NAVEGAÇÃO PRINCIPAL DO APP
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  // CONTROLA QUAL ABA ESTÁ ATIVA
  int _currentIndex = 0;

  // LISTA ESTÁTICA QUE ARMAZENA A ORDEM DAS TELAS QUE SERÃO EXIBIDAS
  final List<Widget> _pages = [
    const HomePage(),
    const InventoryPage(),
    const SalesPage(),
    const ReportsPage(),
    const ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      // BARRA DE NAVEGAÇÃO INFERIOR PERSONALIZADA
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Estoque'),
          BottomNavigationBarItem(icon: Icon(Icons.point_of_sale), label: 'Vendas'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Relatórios'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat IA'),
        ],
        backgroundColor: const Color(0xFF2A1845),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF7A1D5C), 
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}