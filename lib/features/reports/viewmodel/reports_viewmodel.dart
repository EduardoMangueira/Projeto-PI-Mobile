import 'package:flutter/material.dart';

// VIEWMODEL DA TELA DE RELATÓRIOS
class ReportsViewModel extends ChangeNotifier {
  // GETTERS QUE RETORNAM KPIS FINANCEIROS
  double get lucroTotal => 2898.57;
  double get variacao   => 42.74;

  // LISTA DE MAPAS QUE SERVE DE BASE PARA ALIMENTAR O GRÁFICO DE DESEMPENHO MENSAL
  List<Map<String, dynamic>> get desempenho => [
    {'mes': 'Jan', 'valor': 1800.0},
    {'mes': 'Fev', 'valor': 2400.0},
    {'mes': 'Mar', 'valor': 2898.0},
    {'mes': 'Abr', 'valor': 2100.0},
    {'mes': 'Mai', 'valor': 3200.0},
  ];

  // LISTA DE INSIGHTS DE NEGÓCIOS QUE SERÃO EXIBIDOS EM FORMAS DE CARDS OU DICAS DA IA 
  List<Map<String, String>> get insights => [
    {
      'titulo':   'Dia das Mães se aproxima!',
      'descricao': 'Aproveite para montar kits personalizados e aumentar o estoque.',
    },
    {
      'titulo':   'Canecas lideram as vendas!',
      'descricao': 'As canecas ocupam 71% da margem do item, considere ampliar sua variedade.',
    },
  ];
}