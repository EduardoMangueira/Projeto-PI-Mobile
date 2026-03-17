import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

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
              Color(0xFF66686A), 
              Color(0xFF202225),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50), 
                // CONTÊINER PROVISÓRIO (Fingindo a foto/logo)
                // Image.asset('assets/images/logo.png', height: 160)
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

                TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    labelStyle: const TextStyle(color: Color(0xFF505050)), 
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
                  obscureText: true, 
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: const TextStyle(color: Color(0xFF505050)),
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
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        decoration: TextDecoration.underline, 
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40), 

                // BOTÃO LOGIN 
                SizedBox(
                  width: double.infinity,
                  height: 60, 
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7E236C), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), 
                      ),
                      elevation: 5, 
                    ),
                    onPressed: () {
                      // Ação de login 
                    },
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.poppins( 
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),

                // LINK CADASTRE-SE 
                GestureDetector(
                  onTap: () {
                  },
                  child: const Text(
                    'Ainda não tem uma conta? Cadastre-se.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
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