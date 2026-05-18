import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../app/routes/app_routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

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
            colors: [Color(0xFF1B1228), Color(0xFF08080C)],
            stops: [0.44, 0.92],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFB19CD9), Color(0xFFFFA6C9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFCE6F4),
                    ),
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'S',
                              style: TextStyle(
                                fontSize: 80,
                                color: Color(0xFFF371B6),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'serif',
                              ),
                            ),
                            TextSpan(
                              text: 'L',
                              style: TextStyle(
                                fontSize: 80,
                                color: Color(0xFF81257C),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'serif',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'StockFinance\nApp',
                textAlign: TextAlign.center,
                style: GoogleFonts.ovo(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.login,
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF81257C),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}