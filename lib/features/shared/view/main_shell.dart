import 'package:flutter/material.dart';
import '../../home/view/home_page.dart';
import '../../inventory/view/inventory_page.dart';
import '../../chat/view/chat_page.dart';
import '../../sales/view/sales_page.dart';
// import '../../reports/view/reports_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const InventoryPage(),
    const SalesPage(),
    const Center(child: Text('Tela de Relatórios em Construção')),
    const ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
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