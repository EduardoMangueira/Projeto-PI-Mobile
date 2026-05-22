import 'package:flutter/material.dart';

enum Remetente { usuario, ia }

// MODELO QUE ESTRUTURA DADOS BÁSICOS DE CADA BALÃO DE MENSAGEM NO CHAT
class ChatModel {
  final String texto;
  final Remetente remetente;
  ChatModel({required this.texto, required this.remetente});
}

// VIEWMODEL RESPONSÁVEL POR GERENCIAR O HISTÓRICO E FLUXO DE MENSAGENS DA CONVERSA
class ChatViewModel extends ChangeNotifier {
  final List<ChatModel> _mensagens = [];
  List<ChatModel> get mensagens => List.from(_mensagens);
}