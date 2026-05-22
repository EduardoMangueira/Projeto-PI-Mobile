import 'package:flutter/material.dart';
import '../model/notifications_model.dart';

class NotificationsViewModel extends ChangeNotifier {
  // FONTE DE DADOS LOCAL QUE SIMULA O HISTÓRICO DE ALERTAS DO APP
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

  // RETORNA UMA CÓPIA DA LISTA PARA PROTEGER A ORIGINAL CONTRA MODIFICAÇÕES DIRETAS NA VIEW
  List<NotificationsModel> get lista     => List.from(_lista);
  // GETTER QUE FILTRA E CONTA QUANTAS NOTIFICAÇÕES, ALIMENTA O BADGE (BOLINHA VERMELHA) EM TEMPO REAL
  int get naoLidas               => _lista.where((n) => !n.lida).length;

  // PERCORRE TODA A LISTA ALTERANDO O ESTADO DE CADA NOTIFICAÇÃO
  void marcarTodasLidas() {
    for (var n in _lista) {
      n.lida = true;
    }
    notifyListeners();
  }
}