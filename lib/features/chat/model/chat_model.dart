enum Remetente { usuario, ia }

class ChatModel {
  final String texto;
  final Remetente remetente;
  final String horario;
  final bool temConfirmacao;

  ChatModel({
    required this.texto,
    required this.remetente,
    required this.horario,
    this.temConfirmacao = false,
  });
}