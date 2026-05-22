import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodel/profile_viewmodel.dart';

// CLASSE PARA EDITAR OS DADOS DO PERFIL
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // INSTÂNCIA DO VIEWMODEL PARA SEPARAR A LÓGICA DE NEGÓCIO DA UI (MVVM)
  final _vm = ProfileViewModel();

  // CONTROLADORES PARA MANIPULAR OS INPUTS
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nomeController = TextEditingController();

  // ESTADO QUE CONTROLA O FEEDBACK VISUAL DE CARREGAMENTO
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  // MÉTODO ASSÍNCRONO PARA CARREGAR OS DADOS DO VIEWMODEL E PREENCHER OS INPUTS
  Future<void> _carregarDados() async {
    await _vm.carregarDados();
    _emailController.text = _vm.email;
    _nomeController.text = _vm.nomeUsuario;
    
    setState(() {});
  }

  // MÉTODO PARA ENVIAR AS ALTERAÇÕES AO VIEWMODEL
  Future<void> _salvar() async {
    setState(() => _isLoading = true);

    final sucesso = await _vm.salvarAlteracoes(
      novoEmail: _emailController.text.trim(),
      novaSenha: _senhaController.text.trim(),
      novoNome: _nomeController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    // FEEDBACK VISUAL PARA O USUÁRIO
    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Alterações salvas! Se mudou o e-mail, confirme pelo link enviado.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao salvar. Tente fazer login novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  // LIBERA OS CONTROLADORES DA MEMÓRIA
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08080C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF14121C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Editar Perfil',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF3D4E4),
                border: Border.all(color: const Color(0xFFE89B7B), width: 3),
              ),
              child: const Center(
                child: Text(
                  'SL',
                  style: TextStyle(
                    fontSize: 38,
                    color: Color(0xFF7A1D5C),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            _buildField('E-mail', _emailController, TextInputType.emailAddress),
            const SizedBox(height: 16),
            _buildField('Senha', _senhaController, TextInputType.text, obscure: true),
            const SizedBox(height: 16),
            _buildField('Nome de Usuário', _nomeController, TextInputType.text),

            const SizedBox(height: 40),

            // Botão Salvar
            GestureDetector(
              onTap: _isLoading ? null : _salvar,
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6A1B5A), Color(0xFF3E1035)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'SALVAR ALTERAÇÕES',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    TextInputType keyboardType, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF505050)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}