enum TipoNotif { estoqueBaixo, recordeVendas }

class NotificationsModel {
  final String titulo;
  final String mensagem;
  final String data;
  final TipoNotif tipo;
  bool lida;

  NotificationsModel({
    required this.titulo,
    required this.mensagem,
    required this.data,
    required this.tipo,
    this.lida = false,
  });
}