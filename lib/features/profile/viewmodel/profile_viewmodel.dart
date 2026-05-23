import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// VIEWMODEL DE EDIÇÃO DOS DADOS DO USUÁRIO
class ProfileViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String email = '';
  String nomeUsuario = '';

  // CARREGA OS DADOS DO USUÁRIO AUTENTICADO (FIREBASE AUTH E FIRESTORE)
  Future<void> carregarDados() async {
    final user = _auth.currentUser;
    if (user == null) return;

    // BUSCA DADOS INICIAIS DIRETO DO OBJETO DE AUTENTICAÇÃO
    email = user.email ?? '';
    nomeUsuario = user.displayName ?? '';

    // TENTA BUSCAR DADOS ADICIONAIS SALVOS NO FIRESTORE
    try {
      final doc = await _firestore.collection('usuarios').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        if (nomeUsuario.isEmpty) {
          nomeUsuario = doc.data()?['nome'] ?? '';
        }
      }
    } catch (_) {}

    // NOTIFICA A VIEW PARA RECONSTRUIR COM OS NOVOS DADOS
    notifyListeners();
  }

  // ATUALIZA AS INFORMAÇÕES DO PERFIL NO FIREBASE AUTH E NO FIRESTORE
  Future<bool> salvarAlteracoes({
    required String novoEmail,
    required String novaSenha,
    required String novoNome,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    try {
      if (novoNome.isNotEmpty && novoNome != user.displayName) {
        await user.updateDisplayName(novoNome);
      }

      if (novoEmail.isNotEmpty && novoEmail != user.email) {
        await user.verifyBeforeUpdateEmail(novoEmail);
      }

      if (novaSenha.isNotEmpty) {
        await user.updatePassword(novaSenha);
      }

      await _firestore.collection('usuarios').doc(user.uid).set({
        'nome': novoNome,
        'email': novoEmail,
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      debugPrint('Erro ao salvar perfil: $e');
      return false;
    }
  }
}