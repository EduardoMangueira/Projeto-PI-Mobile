import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/inventory_model.dart';

// VIEWMODEL DE GERENCIAMENTO DO INVENTÁRIO
class InventoryViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<InventoryModel> _produtos = [];
  List<InventoryModel> _produtosFiltrados = [];
  String _ultimoTermoBusca = '';

  InventoryViewModel() {
    _ouvirEstoqueRealtime();
  }

  List<InventoryModel> get produtos => _ultimoTermoBusca.isEmpty ? _produtos : _produtosFiltrados;

  // ESCUTA O FIRESTORE EM TEMPO REAL, ATUALIZA A LISTA LOCAL, MANTÉM O FILTRO DE BUSCA ATIVO E NOTIFICA A UI
  void _ouvirEstoqueRealtime() {
    _firestore.collection('produtos').snapshots().listen((snapshot) {
      _produtos = snapshot.docs.map((doc) {
        return InventoryModel.fromFirestore(doc.data(), doc.id);
      }).toList();
      
      if (_ultimoTermoBusca.isNotEmpty) {
        buscar(_ultimoTermoBusca);
      }
      
      notifyListeners();
    });
  }

  // BUSCAR PRODUTO
  void buscar(String termo) {
    _ultimoTermoBusca = termo.toLowerCase();
    if (_ultimoTermoBusca.isEmpty) {
      _produtosFiltrados = [];
    } else {
      _produtosFiltrados = _produtos.where((p) {
        return p.nome.toLowerCase().contains(_ultimoTermoBusca) ||
               p.categoria.toLowerCase().contains(_ultimoTermoBusca);
      }).toList();
    }
    notifyListeners();
  }

// ENVIAR NOVO PRODUTO
  Future<void> adicionar(InventoryModel produto) async {
    if (produto.quantidadeAtual < 0) {
      debugPrint('Operação bloqueada. O estoque não pode ficar negativo.');
      return; 
    }

    try {
      await _firestore.collection('produtos').add(produto.toFirestore());
    } catch (e) {
      debugPrint('Erro ao salvar no Firebase: $e');
    }
  }

  // ATUALIZAR PRODUTO EXISTENTE
  Future<void> editar(InventoryModel produto) async {
    if (produto.quantidadeAtual < 0) {
      debugPrint('Operação bloqueada. O estoque não pode ficar negativo.');
      return; 
    }

    try {
      await _firestore.collection('produtos').doc(produto.id).update(produto.toFirestore());
    } catch (e) {
      debugPrint('Erro ao editar no Firebase: $e');
    }
  }

  // DELETAR PRODUTO
  Future<void> excluir(String id) async {
    try {
      await _firestore.collection('produtos').doc(id).delete();
    } catch (e) {
      debugPrint('Erro ao excluir do Firebase: $e');
    }
  }
}