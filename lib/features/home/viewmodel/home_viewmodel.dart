import 'package:flutter/material.dart';

// VIEWMODEL DA HOME COM OS SALDOS PRINCIPAIS E GERENCIA OS CONTAINERS
class HomeViewModel extends ChangeNotifier {
  final double lucroLiquido = 1250.50;
  final double receitaTotal = 3500.00;
  final double despesas = 2249.50;

  final List<dynamic> ultimasMovimentacoes = [];
  final List<dynamic> grafico = [];
}