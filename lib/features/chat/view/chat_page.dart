import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; 
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../sales/viewmodel/sales_viewmodel.dart';
import '../../sales/model/sales_model.dart';
import '../../inventory/viewmodel/inventory_viewmodel.dart';
import '../../inventory/model/inventory_model.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

// TELA DE CHAT COM ASSISTENTE INTEGRADO À API DO GEMINI, QUE ANALISA O INVENTÁRIO EM TEMPO REAL E REALIZA A BAIXA AUTOMÁTICA DE VENDAS E COMPRAS
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  String _nomeUsuario = "Usuário";
  bool _isTyping = false; 

  late final GenerativeModel _model;
  late final ChatSession _chatSession;

  @override
  void initState() {
    super.initState();
    
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: dotenv.env['GEMINI_API_KEY'] ?? '', 
    );
    _chatSession = _model.startChat();

    _carregarNomeEIniciarChat();
  }

  Future<void> _carregarNomeEIniciarChat() async {
    try {
      final usuarioLogado = FirebaseAuth.instance.currentUser;
      String nomeIdentificado = "";

      if (usuarioLogado != null) {
        if (usuarioLogado.displayName != null && usuarioLogado.displayName!.isNotEmpty) {
          nomeIdentificado = usuarioLogado.displayName!;
        } else {
          final docUsuario = await FirebaseFirestore.instance
              .collection('usuarios')
              .doc(usuarioLogado.uid)
              .get();
              
          if (docUsuario.exists && docUsuario.data() != null) {
            nomeIdentificado = docUsuario.data()?['nome'] ?? "";
          }
        }
      }

      setState(() {
        _nomeUsuario = nomeIdentificado.trim().isNotEmpty ? nomeIdentificado.split(' ')[0] : "parceiro(a)";
        _messages.add(
          ChatMessage(
            text: 'Olá, $_nomeUsuario! Sou a IA StockFinance. Pode me reportar suas vendas ou fazer perguntas sobre lucros e projeções do estoque!',
            isUser: false,
          ),
        );
      });
    } catch (e) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: 'Olá! Sou a IA do StockFinance. Como posso ajudar com os seus lançamentos hoje?',
            isUser: false,
          ),
        );
      });
    }
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isTyping = true;
    });
    
    _controller.clear();

    final salesVm = context.read<SalesViewModel>();
    final invVm = context.read<InventoryViewModel>();
    
    String resumoEstoque = invVm.produtos.isEmpty 
        ? "Nenhum produto cadastrado no estoque." 
        : invVm.produtos.map((p) => '- Produto: "${p.nome}" | Estoque atual: ${p.quantidadeAtual} | Custo: R\$ ${p.precoCompra.toStringAsFixed(2)} | Venda: R\$ ${p.precoVenda.toStringAsFixed(2)}').join('\n');

    String promptSecreto = '''
Você é a IA Diretora Financeira e Operacional do StockFinance, especialista em sublimação.

DADOS REAIS DA EMPRESA:
- Lucro Total Líquido: R\$ ${salesVm.lucroLiquido.toStringAsFixed(2)}
- Margem de Lucro: ${salesVm.margemLucro.toStringAsFixed(1)}%

ESTOQUE E PREÇOS:
$resumoEstoque

SUAS DUAS TAREFAS PRINCIPAIS:
1. ANÁLISE FINANCEIRA E MATEMÁTICA: Se o usuário fizer perguntas sobre projeções, custos para repor estoque, lucros ou situação atual, faça os cálculos matemáticos exatos baseados nos preços e quantidades acima. Responda de forma direta, listando os valores (Ex: para chegar a 100 unidades, você precisa comprar X, custando Y).
2. REGISTRO DE VENDAS/COMPRAS: Se o usuário relatar que ACABOU DE VENDER ou COMPRAR algo, responda confirmando e adicione obrigatoriamente na última linha o comando oculto: |||ACAO;NOME_DO_PRODUTO;QUANTIDADE||| (Ex: |||venda;Caneca;5|||).

Se não for um registro prático de venda/compra, não use o comando |||.
Responda de forma clara, prestativa e como uma consultora parceira do negócio.

Pergunta do usuário: $text
''';

    try {
      final response = await _chatSession.sendMessage(Content.text(promptSecreto));
      String respostaCompleta = response.text ?? '';
      String textoParaExibir = respostaCompleta;
      
      if (respostaCompleta.contains('|||')) {
        final partesRaw = respostaCompleta.split('|||');
        textoParaExibir = partesRaw[0].trim(); 
        final comandoOculto = partesRaw[1].trim(); 
        
        try {
          final partesComando = comandoOculto.split(';');
          final acao = partesComando[0].trim().toLowerCase(); 
          final nomeProdutoAlvo = partesComando[1].trim();
          final quantidadeReg = int.tryParse(partesComando[2].trim()) ?? 0;

          final produtosCompativeis = invVm.produtos.where((p) {
            final nomeDoBanco = p.nome.toLowerCase();
            final nomeVindoDaIA = nomeProdutoAlvo.toLowerCase();
            return nomeDoBanco.contains(nomeVindoDaIA) || nomeVindoDaIA.contains(nomeDoBanco);
          }).toList();

          if (produtosCompativeis.isEmpty) {
            textoParaExibir += "\n\n⚠️ (Não encontrei o produto '$nomeProdutoAlvo').";
          } else if (quantidadeReg > 0) {
            final produto = produtosCompativeis.first; 
            final isVenda = acao == 'venda';
            
            if (isVenda && produto.quantidadeAtual < quantidadeReg) {
              textoParaExibir += "\n\n⚠️ (Venda bloqueada: Estoque insuficiente. Restam ${produto.quantidadeAtual}).";
            } else {
              final precoUnitario = isVenda ? produto.precoVenda : produto.precoCompra;
              final valorTotalMov = precoUnitario * quantidadeReg;
              final novaQtd = isVenda ? produto.quantidadeAtual - quantidadeReg : produto.quantidadeAtual + quantidadeReg;

              final prodAtualizado = InventoryModel(
                id: produto.id,
                nome: produto.nome,
                categoria: produto.categoria,
                precoCompra: produto.precoCompra,
                precoVenda: produto.precoVenda,
                quantidadeAtual: novaQtd,
                estoqueMinimo: produto.estoqueMinimo,
              );
              await invVm.editar(prodAtualizado);

              await salesVm.adicionarMovimentacao(
                produto.id,
                produto.nome,
                quantidadeReg,
                valorTotalMov,
                isVenda ? TipoMov.venda : TipoMov.compra,
              );
              
              textoParaExibir += " ✅ (Lançamento automático efetuado!)";
            }
          }
        } catch (erroInterno) {
          textoParaExibir += "\n\n⚠️ (Falha ao processar a automação deste item).";
        }
      }

      setState(() {
        _isTyping = false;
        _messages.add(ChatMessage(text: textoParaExibir, isUser: false));
      });

    } catch (e) {
      print("🚨 ERRO REAL DO GEMINI: $e"); 
      setState(() {
        _isTyping = false;
        _messages.add(
          ChatMessage(
            text: 'Erro técnico detalhado: $e',
            isUser: false,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08080C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF14121C),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, color: Color(0xFFBB4FCF), size: 20),
            const SizedBox(width: 8),
            Text(
              'Assistente IA',
              style: GoogleFonts.anekBangla(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? const Center(child: CircularProgressIndicator(color: Color(0xFFBB4FCF)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      return _buildMessageBubble(msg);
                    },
                  ),
          ),
          
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Analisando os dados...',
                  style: GoogleFonts.aoboshiOne(color: const Color(0xFF7A6A9A), fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ),
            ),

          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        decoration: BoxDecoration(
          gradient: msg.isUser
              ? const LinearGradient(colors: [Color(0xFF5000BF), Color(0xFFAE00FF)])
              : null,
          color: msg.isUser ? null : const Color(0xFF2A1845),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isUser ? 16 : 0),
            bottomRight: Radius.circular(msg.isUser ? 0 : 16),
          ),
        ),
        child: Text(
          msg.text,
          style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: const BoxDecoration(
        color: Color(0xFF14121C),
        border: Border(top: BorderSide(color: Color(0xFF313131))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Pergunte sobre projeções ou lance uma venda...',
                hintStyle: const TextStyle(color: Color(0xFF7A6A9A), fontSize: 13),
                filled: true,
                fillColor: const Color(0xFF2A1845),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF5000BF), Color(0xFFAE00FF)]),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}