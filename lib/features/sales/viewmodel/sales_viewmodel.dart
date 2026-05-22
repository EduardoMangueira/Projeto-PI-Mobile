import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/sales_model.dart';

// VIEWMODEL RESPONSÁVEL POR GERENCIAR AS REGRAS DE NEGÓCIO DE FLUXO DE CAIXA E RELATÓRIOS
class SalesViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  String _filtro = 'Todas';
  String get filtro => _filtro;

  List<SalesModel> _todas = [];

  // CONSTRUTOR INICIALIZA A ESCUTA ATIVA DO BANCO DE DADOS
  SalesViewModel() {
    _escutarMovimentacoes();
  }

  // CRIA UM CANAL DE COMUNICAÇÃO EM TEMPO REAL (STREAM) COM O CLOUD FIRESTORE
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

  // GETTER QUE APLICA O FILTRO SELECIONADO (VENDAS, DESPESAS OU TODAS) SOBRE O CACHE LOCAL
  List<SalesModel> get movimentacoes {
    if (_filtro == 'Vendas') return _todas.where((m) => m.tipo == TipoMov.venda).toList();
    if (_filtro == 'Despesas') return _todas.where((m) => m.tipo == TipoMov.compra).toList();
    return List.from(_todas);
  }

  // ATUALIZA O FILTRO SELECIONADO REDESENHANDO APENAS A LISTA CORRESPONDENTE
  void setFiltro(String f) {
    _filtro = f;
    notifyListeners();
  }

  // REGISTRA UMA NOVA MOVIMENTAÇÃO FINANCEIRA DIRETAMENTE NO BANCO DE DADOS
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

  // GETTERS ANALÍTICOS DA PARTE FINANCEIRA E RELATÓRIOS
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

  // ESTRUTURA DE REPETIÇÃO QUE AGRUPA RECEITAS E DESPESAS PARA ALIMENTAR GRÁFICOS DE BARRAS/LINHAS
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
