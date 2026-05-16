import 'package:flutter/material.dart';
import '../model/sales_model.dart';

class SalesViewModel extends ChangeNotifier {
  String _filtro = 'Todas';
  String get filtro => _filtro;

  final List<SalesModel> _todas = [
    SalesModel(id: '1', produtoId: 'p1', item: 'Chaveiro Acrílico', quantidade: 10, valor: -160.0, data: '03 mai, 10:17', tipo: TipoMov.compra),
    SalesModel(id: '4', produtoId: 'p2', item: 'Caneca Branca', quantidade: 1, valor: 45.0, data: '02 mai, 14:30', tipo: TipoMov.venda),
  ];

  List<SalesModel> get movimentacoes {
    if (_filtro == 'Vendas') return _todas.where((m) => m.tipo == TipoMov.venda).toList();
    if (_filtro == 'Despesas') return _todas.where((m) => m.tipo == TipoMov.compra).toList();
    return List.from(_todas);
  }

  void setFiltro(String f) {
    _filtro = f;
    notifyListeners();
  }

  void adicionarMovimentacao(String produtoId, String item, int quantidade, double valor, TipoMov tipo) {
    final agora = DateTime.now();
    final meses = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
    final dataFormatada = '${agora.day.toString().padLeft(2, '0')} ${meses[agora.month - 1]}, ${agora.hour.toString().padLeft(2, '0')}:${agora.minute.toString().padLeft(2, '0')}';

    final novaMovimentacao = SalesModel(
      id: agora.millisecondsSinceEpoch.toString(),
      produtoId: produtoId,
      item: item,
      quantidade: quantidade,
      valor: tipo == TipoMov.compra ? -valor.abs() : valor.abs(),
      data: dataFormatada,
      tipo: tipo,
    );

    _todas.insert(0, novaMovimentacao); 
    notifyListeners();
  }

  double get receitaTotal => _todas.where((m) => m.tipo == TipoMov.venda).fold(0.0, (s, i) => s + i.valor.abs());
  double get despesas => _todas.where((m) => m.tipo == TipoMov.compra).fold(0.0, (s, i) => s + i.valor.abs());
  double get lucroLiquido => receitaTotal - despesas;
  List<SalesModel> get ultimasMovimentacoes => _todas.take(5).toList();

  double get margemLucro {
    if (receitaTotal <= 0) return 0.0;
    return (lucroLiquido / receitaTotal) * 100;
  }

  double get percentualDespesas {
    if (receitaTotal <= 0) return 0.0;
    return (despesas / receitaTotal) * 100;
  }
}
