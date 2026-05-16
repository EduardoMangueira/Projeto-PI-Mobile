import 'package:flutter/material.dart';
import '../model/notifications_model.dart';

class NotificationsViewModel extends ChangeNotifier {
  final List<NotificationsModel> _lista = [
    NotificationsModel(
      titulo:   'Estoque Baixo: Canecas de Alumínio Ouro',
      mensagem: 'Apenas 1 unidade. Mínimo recomendado: 10',
      data:     '15 mar, 17:20',
      tipo:     TipoNotif.estoqueBaixo,
    ),
    NotificationsModel(
      titulo:   'Estoque Baixo: Camiseta Branca',
      mensagem: 'Apenas 5 unidades. Reposição recomendada.',
      data:     '15 mar, 16:30',
      tipo:     TipoNotif.estoqueBaixo,
    ),
    NotificationsModel(
      titulo:   'Recorde de Vendas!',
      mensagem: 'Você acabou de ultrapassar o volume de vendas em 20%',
      data:     '15 mar, 13:20',
      tipo:     TipoNotif.recordeVendas,
    ),
  ];

  List<NotificationsModel> get lista     => List.from(_lista);
  int get naoLidas               => _lista.where((n) => !n.lida).length;

  void marcarTodasLidas() {
    for (var n in _lista) {
      n.lida = true;
    }
    notifyListeners();
  }
}