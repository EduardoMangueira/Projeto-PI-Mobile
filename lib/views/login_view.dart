import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodels/login_viewmodel.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final LoginViewModel _viewModel = LoginViewModel();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool _isLoading = false;

  void _realizarLogin() async {
    setState(() {
      _isLoading = true;
    });

    bool sucesso = await _viewModel.fazerLogin(
      _usuarioController.text,
      _senhaController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!'), backgroundColor: Colors.green),
      );
      // navega para a tela home
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário ou senha incorretos.'), backgroundColor: Colors.red),
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
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: [
                const SizedBox(height: 70),

                // LOGO
                Container(
                  width: 160, 
                  height: 160,
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
                        fontSize: 70,
                        color: Color(0xFF7A1D5C),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 70),

                // CAMPO USUÁRIO
                TextField(
                  controller: _usuarioController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    labelStyle: const TextStyle(color: Color(0xFF505050)), 
                    // Essa linha faz o texto sumir ao clicar no campo:
                    floatingLabelBehavior: FloatingLabelBehavior.never, 
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),

                // CAMPO SENHA 
                TextField(
                  controller: _senhaController,
                  obscureText: true, 
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: const TextStyle(color: Color(0xFF505050)),
                    // Essa linha faz o texto sumir ao clicar no campo:
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                
                const SizedBox(height: 10),

                // LINK ESQUECI MINHA SENHA 
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () => _viewModel.recuperarSenha(context), 
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        decoration: TextDecoration.underline, 
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 80), 

                // BOTÃO LOGIN
                GestureDetector(
                  onTap: _isLoading ? null : _realizarLogin,
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
                              'LOGIN',
                              style: GoogleFonts.poppins( 
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),

                // LINK CADASTRE-SE 
                GestureDetector(
                  onTap: () => _viewModel.irParaCadastro(context),
                  child: const Text(
                    'Ainda não tem uma conta? Cadastre-se.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}