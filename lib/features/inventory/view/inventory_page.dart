import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/inventory_model.dart';
import '../viewmodel/inventory_viewmodel.dart';
import '../../notifications/viewmodel/notifications_viewmodel.dart';
import 'package:projeto_pi_mobile/app/routes/app_routes.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<InventoryViewModel>();
    final notifVm = context.watch<NotificationsViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF08080C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09080D),
        elevation: 0,
        title: Text(
          'StockFinance',
          style: GoogleFonts.aoboshiOne(
            color: const Color(0xFFBB4FCF),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.notifications),
              ),
              if (notifVm.naoLidas > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF2D1B4E),
              child: Icon(Icons.person, color: Color(0xFF7A6A9A), size: 18),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Inventário',
                  style: GoogleFonts.anekBangla(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => _abrirModal(context, null),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF5000BF), Color(0xFFAE00FF)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'ADICIONAR ITEM +',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: vm.buscar,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar produtos...',
                hintStyle: GoogleFonts.aoboshiOne(
                  color: const Color(0xFF7A6A9A),
                ),
                filled: true,
                fillColor: const Color(0xFF2A1845),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF7A6A9A)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: vm.produtos.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum produto.',
                      style: TextStyle(color: Color(0xFF7A6A9A)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: vm.produtos.length,
                    itemBuilder: (ctx, i) {
                      final p = vm.produtos[i];
                      return _TileProduto(
                        produto: p,
                        onEditar: () => _abrirModal(context, p),
                        onExcluir: () => vm.excluir(p.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _abrirModal(BuildContext context, InventoryModel? p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF2D1B4E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ModalProduto(produto: p),
    );
  }
}

class _TileProduto extends StatelessWidget {
  final InventoryModel produto;
  final VoidCallback onEditar;
  final VoidCallback onExcluir;

  const _TileProduto({
    required this.produto,
    required this.onEditar,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: produto.estoqueCritico
            ? const Color(0xFF460F01)
            : const Color(0xFF14121C),
        borderRadius: BorderRadius.circular(12),
        border: produto.estoqueCritico ? Border.all(color: Colors.red) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF3D2560),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: Color(0xFF7A6A9A),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produto.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                Text(
                  '${produto.categoria} • R\$ ${produto.precoVenda.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF7A6A9A),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${produto.quantidadeAtual} itens',
                style: TextStyle(
                  color: produto.estoqueCritico ? Colors.red : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              if (produto.estoqueCritico)
                const Text(
                  'Crítico',
                  style: TextStyle(color: Colors.red, fontSize: 10),
                ),
            ],
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: Color(0xFFBB4FCF),
              size: 18,
            ),
            onPressed: onEditar,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
            onPressed: onExcluir,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

class _ModalProduto extends StatefulWidget {
  final InventoryModel? produto;
  const _ModalProduto({this.produto});

  @override
  State<_ModalProduto> createState() => _ModalProdutoState();
}

class _ModalProdutoState extends State<_ModalProduto> {
  late final TextEditingController _nome;
  late final TextEditingController _categoria;
  late final TextEditingController _precoC;
  late final TextEditingController _precoV;
  late final TextEditingController _qtd;
  late final TextEditingController _min;

  @override
  void initState() {
    super.initState();
    final p = widget.produto;
    _nome = TextEditingController(text: p?.nome ?? '');
    _categoria = TextEditingController(text: p?.categoria ?? '');
    _precoC = TextEditingController(
      text: p != null ? p.precoCompra.toString() : '',
    );
    _precoV = TextEditingController(
      text: p != null ? p.precoVenda.toString() : '',
    );
    _qtd = TextEditingController(
      text: p != null ? p.quantidadeAtual.toString() : '',
    );
    _min = TextEditingController(
      text: p != null ? p.estoqueMinimo.toString() : '',
    );
  }

  @override
  void dispose() {
    _nome.dispose();
    _categoria.dispose();
    _precoC.dispose();
    _precoV.dispose();
    _qtd.dispose();
    _min.dispose();
    super.dispose();
  }

  void _salvar() {
    final vm = context.read<InventoryViewModel>();
    final novo = InventoryModel(
      id:
          widget.produto?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      nome: _nome.text,
      categoria: _categoria.text,
      precoCompra: double.tryParse(_precoC.text) ?? 0,
      precoVenda: double.tryParse(_precoV.text) ?? 0,
      quantidadeAtual: int.tryParse(_qtd.text) ?? 0,
      estoqueMinimo: int.tryParse(_min.text) ?? 0,
    );
    widget.produto == null ? vm.adicionar(novo) : vm.editar(novo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.produto == null ? 'Novo Produto' : 'Editar Produto',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _field('Nome do Produto', _nome),
          const SizedBox(height: 10),
          _field('Categoria', _categoria),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _field(
                  'Preço de Compra',
                  _precoC,
                  tipo: TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _field(
                  'Preço de Venda',
                  _precoV,
                  tipo: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _field('Qtd Atual', _qtd, tipo: TextInputType.number),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _field(
                  'Estoque Mínimo',
                  _min,
                  tipo: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _salvar,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF5000BF), Color(0xFFAE00FF)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Salvar Produto',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    String hint,
    TextEditingController ctrl, {
    TextInputType? tipo,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: tipo,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF7A6A9A), fontSize: 12),
        filled: true,
        fillColor: const Color(0xFF3D2560),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
    );
  }
}
