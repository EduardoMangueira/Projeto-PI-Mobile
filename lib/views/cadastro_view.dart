import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodels/cadastro_viewmodel.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final CadastroViewModel _viewModel = CadastroViewModel();

  // Os 4 campos
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  bool _isLoading = false;

  void _realizarCadastro() async {
    setState(() {
      _isLoading = true;
    });

    // Passa os dados digitados para o ViewModel
    bool sucesso = await _viewModel.cadastrar(
      _emailController.text,
      _senhaController.text,
      _usuarioController.text,
      _telefoneController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!'), backgroundColor: Colors.green),
      );
      // Volta para a tela de login após cadastrar
      Navigator.pop(context); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos!'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B1228), 
              Color(0xFF08080C), 
            ],
            stops: [0.44, 0.92], 
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
            child: Column(
              children: [
                // CONTÊINER DA LOGO
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, 
                    color: const Color(0xFFF3D4E4), 
                    border: Border.all(
                      color: const Color(0xFFE89B7B), 
                      width: 4, 
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'SL',
                      style: TextStyle(
                        fontSize: 60,
                        color: Color(0xFF7A1D5C),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 50),

                // CAMPO E-MAIL
                _buildTextField(
                  controller: _emailController,
                  label: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                ),
                
                const SizedBox(height: 16),

                // CAMPO SENHA 
                _buildTextField(
                  controller: _senhaController,
                  label: 'Senha',
                  obscureText: true,
                ),

                const SizedBox(height: 16),

                // CAMPO NOME DE USUÁRIO
                _buildTextField(
                  controller: _usuarioController,
                  label: 'Nome de Usuário',
                ),

                const SizedBox(height: 16),

                // CAMPO TELEFONE
                _buildTextField(
                  controller: _telefoneController,
                  label: 'Telefone',
                  keyboardType: TextInputType.phone,
                ),
                
                const SizedBox(height: 50), 

                // BOTÃO CADASTRAR
                GestureDetector(
                  onTap: _isLoading ? null : _realizarCadastro,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6A1B5A),
                          Color(0xFF3E1035),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isLoading 
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'CADASTRAR',
                              style: GoogleFonts.poppins( 
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função para não ficar repetitivo nos campos iguais
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF808080)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}