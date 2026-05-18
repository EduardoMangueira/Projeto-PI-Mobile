import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../viewmodel/sales_viewmodel.dart';
import '../model/sales_model.dart';
import '../../inventory/viewmodel/inventory_viewmodel.dart';
import '../../inventory/model/inventory_model.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  void _abrirModalNovaMovimentacao() {
    final inventoryVm = context.read<InventoryViewModel>();
    
    InventoryModel? produtoSelecionado;
    final qtdController = TextEditingController(text: '1');
    final valorController = TextEditingController();
    final nomeAvulsoController = TextEditingController();
    
    TipoMov tipoSelecionado = TipoMov.venda;
    bool isAvulso = false; 

    void atualizarValorTotal() {
      if (!isAvulso && produtoSelecionado != null) {
        final qtd = int.tryParse(qtdController.text) ?? 1;
        final precoCorreto = tipoSelecionado == TipoMov.venda 
            ? produtoSelecionado!.precoVenda 
            : produtoSelecionado!.precoCompra;
        valorController.text = (precoCorreto * qtd).toStringAsFixed(2);
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF14121C),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nova Movimentação', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() {
                              isAvulso = false;
                              atualizarValorTotal();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: !isAvulso ? const Color(0xFFBB4FCF) : const Color(0xFF2A1845),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text('Do Estoque', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() {
                              isAvulso = true;
                              valorController.clear();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isAvulso ? const Color(0xFFBB4FCF) : const Color(0xFF2A1845),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text('Contas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  if (!isAvulso)
                    DropdownButtonFormField<InventoryModel>(
                      value: produtoSelecionado,
                      dropdownColor: const Color(0xFF36285A),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: inventoryVm.produtos.isEmpty ? 'Estoque vazio!' : 'Selecione o Produto',
                        hintStyle: const TextStyle(color: Color(0xFF7A6A9A)),
                        filled: true,
                        fillColor: const Color(0xFF36285A),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                      items: inventoryVm.produtos.map((p) {
                        return DropdownMenuItem(
                          value: p,
                          child: Text('${p.nome} (Estoque: ${p.quantidadeAtual})'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setModalState(() {
                          produtoSelecionado = val;
                          atualizarValorTotal();
                        });
                      },
                    )
                  else
                    TextField(
                      controller: nomeAvulsoController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Ex: Embalagens',
                        hintStyle: const TextStyle(color: Color(0xFF7A6A9A)),
                        filled: true,
                        fillColor: const Color(0xFF36285A),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),

                  const SizedBox(height: 12),
                  
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: qtdController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            labelText: 'Qtd',
                            labelStyle: const TextStyle(color: Color(0xFF7A6A9A)),
                            filled: true,
                            fillColor: const Color(0xFF36285A),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                          ),
                          onChanged: (text) {
                            atualizarValorTotal(); 
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: valorController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(
                            labelText: 'Valor Total (R\$)',
                            labelStyle: const TextStyle(color: Color(0xFF7A6A9A)),
                            filled: true,
                            fillColor: const Color(0xFF36285A),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() {
                              tipoSelecionado = TipoMov.venda;
                              atualizarValorTotal(); 
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: tipoSelecionado == TipoMov.venda ? Colors.green.withOpacity(0.3) : const Color(0xFF2A1845),
                              border: Border.all(color: tipoSelecionado == TipoMov.venda ? Colors.green : Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text('Receita (+)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() {
                              tipoSelecionado = TipoMov.compra;
                              atualizarValorTotal(); 
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: tipoSelecionado == TipoMov.compra ? Colors.red.withOpacity(0.3) : const Color(0xFF2A1845),
                              border: Border.all(color: tipoSelecionado == TipoMov.compra ? Colors.red : Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text('Despesa (-)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  GestureDetector(
                    onTap: () {
                      final qtd = int.tryParse(qtdController.text) ?? 0;
                      final valor = double.tryParse(valorController.text.replaceAll(',', '.')) ?? 0.0;
                      
                      if (qtd <= 0 || valor <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Valores inválidos!'), backgroundColor: Colors.red));
                        return;
                      }
                      if (isAvulso) {
                        final nome = nomeAvulsoController.text.trim();
                        if (nome.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Digite o nome do item!'), backgroundColor: Colors.red));
                          return;
                        }

                        context.read<SalesViewModel>().adicionarMovimentacao(
                          'avulso_${DateTime.now().millisecondsSinceEpoch}',
                          nome,
                          qtd,
                          valor,
                          tipoSelecionado
                        );
                        Navigator.pop(context);
                        return;
                      }
                      
                      if (!isAvulso && produtoSelecionado == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecione um produto!'), backgroundColor: Colors.red));
                        return;
                      }

                      if (tipoSelecionado == TipoMov.venda && produtoSelecionado!.quantidadeAtual < qtd) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Venda bloqueada! Você só tem ${produtoSelecionado!.quantidadeAtual} unidades de ${produtoSelecionado!.nome} no estoque.'), 
                            backgroundColor: Colors.red
                          )
                        );
                        return;
                      }

                      final novaQtd = tipoSelecionado == TipoMov.venda
                          ? produtoSelecionado!.quantidadeAtual - qtd
                          : produtoSelecionado!.quantidadeAtual + qtd;
                          
                      final prodAtualizado = InventoryModel(
                          id: produtoSelecionado!.id,
                          nome: produtoSelecionado!.nome,
                          categoria: produtoSelecionado!.categoria,
                          precoCompra: produtoSelecionado!.precoCompra,
                          precoVenda: produtoSelecionado!.precoVenda,
                          quantidadeAtual: novaQtd,
                          estoqueMinimo: produtoSelecionado!.estoqueMinimo,
                      );
                      context.read<InventoryViewModel>().editar(prodAtualizado);

                      context.read<SalesViewModel>().adicionarMovimentacao(
                        produtoSelecionado!.id,
                        produtoSelecionado!.nome,
                        qtd,
                        valor,
                        tipoSelecionado
                      );

                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF5000BF), Color(0xFFAE00FF)]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text('Registrar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SalesViewModel>();
    const filtros = ['Todas', 'Receitas', 'Despesas'];

    return Scaffold(
      backgroundColor: const Color(0xFF08080C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF08080C),
        elevation: 0,
        title: const Text('Caixa e Vendas', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              'Vendas e Compras',
              style: GoogleFonts.anekBangla(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: filtros.map((f) {
                String termoFiltro = f;
                if (f == 'Receitas') termoFiltro = 'Vendas';

                final ativo = vm.filtro == termoFiltro;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => vm.setFiltro(termoFiltro),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: ativo ? const LinearGradient(colors: [Color(0xFF5000BF), Color(0xFFAE00FF)]) : null,
                        color: ativo ? null : const Color(0xFF2A1845),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                          color: ativo ? Colors.white : const Color(0xFF7A6A9A),
                          fontWeight: ativo ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: vm.movimentacoes.isEmpty
                ? const Center(child: Text('Nenhuma movimentação.', style: TextStyle(color: Color(0xFF7A6A9A))))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: vm.movimentacoes.length,
                    itemBuilder: (ctx, i) {
                      final m = vm.movimentacoes[i];
                      final isVenda = m.tipo == TipoMov.venda;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF14121C),
                          border: Border.all(color: const Color(0xFF313131)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: isVenda ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                                border: Border.all(color: isVenda ? Colors.green : Colors.red, width: 1.5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isVenda ? Icons.arrow_upward : Icons.arrow_downward,
                                color: isVenda ? Colors.green : Colors.red,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${m.quantidade}x ${m.item}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13)),
                                  Text(m.data, style: const TextStyle(color: Color(0xFF7A6A9A), fontSize: 11)),
                                ],
                              ),
                            ),
                            Text(
                              'R\$ ${m.valor.abs().toStringAsFixed(2)}',
                              style: TextStyle(
                                color: isVenda ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFBB4FCF),
        onPressed: _abrirModalNovaMovimentacao,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}