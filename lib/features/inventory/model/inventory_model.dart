// CLASSE MODELO DE INVENTÁRIO
class InventoryModel {
  final String id;
  final String nome;
  final String categoria;
  final double precoCompra;
  final double precoVenda;
  final int quantidadeAtual;
  final int estoqueMinimo;

  InventoryModel({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.precoCompra,
    required this.precoVenda,
    required this.quantidadeAtual,
    required this.estoqueMinimo,
  });

  bool get estoqueCritico => quantidadeAtual <= estoqueMinimo;

  // TRADUZ OS DADOS QUE VÊM DO FIREBASE PARA O APLICATIVO
  factory InventoryModel.fromFirestore(Map<String, dynamic> data, String documentId) {
    return InventoryModel(
      id: documentId,
      nome: data['nome'] ?? '',
      categoria: data['categoria'] ?? '',
      precoCompra: (data['precoCompra'] ?? 0.0).toDouble(),
      precoVenda: (data['precoVenda'] ?? 0.0).toDouble(),
      quantidadeAtual: data['quantidadeAtual'] ?? 0,
      estoqueMinimo: data['estoqueMinimo'] ?? 0,
    );
  }

  // PREPARA OS DADOS PARA ENVIAR PARA O FIREBASE
  Map<String, dynamic> toFirestore() {
    return {
      'nome': nome,
      'categoria': categoria,
      'precoCompra': precoCompra,
      'precoVenda': precoVenda,
      'quantidadeAtual': quantidadeAtual,
      'estoqueMinimo': estoqueMinimo,
    };
  }
}