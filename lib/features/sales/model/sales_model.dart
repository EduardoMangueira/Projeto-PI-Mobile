import 'package:cloud_firestore/cloud_firestore.dart';

enum TipoMov { venda, compra }

class SalesModel {
  final String id;
  final String produtoId;
  final String item;
  final int quantidade;
  final double valor;
  final String data;
  final TipoMov tipo;

  SalesModel({
    required this.id,
    required this.produtoId,
    required this.item,
    required this.quantidade,
    required this.valor,
    required this.data,
    required this.tipo,
  });

  // PREPARA OS DADOS PARA ENVIAR PARA O FIREBASE
  Map<String, dynamic> toMap() {
    return {
      'produtoId': produtoId,
      'item': item,
      'quantidade': quantidade,
      'valor': valor,
      'data': data,
      'tipo': tipo == TipoMov.venda ? 'venda' : 'compra',
      'timestamp': FieldValue.serverTimestamp(), 
    };
  }

  // TRADUZ OS DADOS QUE VÊM DO FIREBASE PARA O APLICATIVO
  factory SalesModel.fromMap(String docId, Map<String, dynamic> map) {
    return SalesModel(
      id: docId,
      produtoId: map['produtoId'] ?? '',
      item: map['item'] ?? '',
      quantidade: map['quantidade']?.toInt() ?? 1,
      valor: map['valor']?.toDouble() ?? 0.0,
      data: map['data'] ?? '',
      tipo: map['tipo'] == 'compra' ? TipoMov.compra : TipoMov.venda,
    );
  }
}