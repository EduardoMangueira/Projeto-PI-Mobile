import 'package:flutter/material.dart';

enum Remetente { usuario, ia }

class ChatModel {
  final String texto;
  final Remetente remetente;
  ChatModel({required this.texto, required this.remetente});
}

class ChatViewModel extends ChangeNotifier {
  final List<ChatModel> _mensagens = [];
  List<ChatModel> get mensagens => List.from(_mensagens);
}