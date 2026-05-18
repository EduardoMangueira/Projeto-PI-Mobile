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
}