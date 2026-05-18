import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/sales_model.dart';

class SalesViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  String _filtro = 'Todas';
  String get filtro => _filtro;

  List<SalesModel> _todas = [];

  SalesViewModel() {
    _escutarMovimentacoes();
  }

  void _escutarMovimentacoes() {
    _firestore
        .collection('movimentacoes')
        .orderBy('timestamp', descending: true) 
        .snapshots()
        .listen((snapshot) {
      _todas = snapshot.docs
          .map((doc) => SalesModel.fromMap(doc.id, doc.data()))
          .toList();
      notifyListeners();
    });
  }

  List<SalesModel> get movimentacoes {
    if (_filtro == 'Vendas') return _todas.where((m) => m.tipo == TipoMov.venda).toList();
    if (_filtro == 'Despesas') return _todas.where((m) => m.tipo == TipoMov.compra).toList();
    return List.from(_todas);
  }

  void setFiltro(String f) {
    _filtro = f;
    notifyListeners();
  }

  Future<void> adicionarMovimentacao(String produtoId, String item, int quantidade, double valor, TipoMov tipo) async {
    final agora = DateTime.now();
    final meses = ['jan', 'fev', 'mar', 'abr', 'mai', 'jun', 'jul', 'ago', 'set', 'out', 'nov', 'dez'];
    final dataFormatada = '${agora.day.toString().padLeft(2, '0')} ${meses[agora.month - 1]}, ${agora.hour.toString().padLeft(2, '0')}:${agora.minute.toString().padLeft(2, '0')}';

    final novaMov = SalesModel(
      id: '',
      produtoId: produtoId,
      item: item,
      quantidade: quantidade,
      valor: tipo == TipoMov.compra ? -valor.abs() : valor.abs(),
      data: dataFormatada,
      tipo: tipo,
    );

    await _firestore.collection('movimentacoes').add(novaMov.toMap());
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
  List<Map<String, dynamic>> get dadosDoGrafico {
    final agora = DateTime.now();
    final mesesNomes = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];
    
    List<Map<String, dynamic>> grafico = [];
    
    for (int i = 4; i >= 0; i--) {
      int mesAlvo = agora.month - i;
      int anoAlvo = agora.year;
      
      if (mesAlvo <= 0) {
        mesAlvo += 12;
        anoAlvo -= 1;
      }
      final nomeMes = mesesNomes[mesAlvo - 1].toLowerCase();
      
      final movsDoMes = _todas.where((m) {
        return m.data.toLowerCase().contains(nomeMes);
      }).toList();

      final rec = movsDoMes.where((m) => m.tipo == TipoMov.venda).fold(0.0, (s, i) => s + i.valor.abs());
      final des = movsDoMes.where((m) => m.tipo == TipoMov.compra).fold(0.0, (s, i) => s + i.valor.abs());

      grafico.add({
        'mes': mesesNomes[mesAlvo - 1],
        'receita': rec,
        'despesa': des,
      });
    }
    return grafico;
  }
}
