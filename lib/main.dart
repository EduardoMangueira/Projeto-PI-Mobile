import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // INICIALIZAÇÃO DAS BINDINGS NATIVAS DO FLUTTER
  WidgetsFlutterBinding.ensureInitialized(); 
  
  // INICIALIZAÇÃO DOS SERVIÇOS DO FIREBASE
  await Firebase.initializeApp();
  // CARREGA AS CONFIGURAÇÕES DO ARQUIVO .env
  await dotenv.load(fileName: ".env");

  // INICIALIZA O APLICATIVO
  runApp(const AppWidget());
}