import 'package:flutter/material.dart';
import 'package:projeto_pi_mobile/app/routes/app_routes.dart';
import '../../features/auth/view/login_page.dart';
import '../../features/auth/view/splash_page.dart';
import '../../features/auth/view/signup_page.dart';
import '../../features/shared/view/main_shell.dart';
import '../../features/notifications/view/notifications_page.dart';
import '../../features/profile/view/profile_page.dart';

// CLASSE PARA CENTRALIZAR O MAPEAMENTO DE ROTAS NOMEADAS DO APP
class AppPages {
  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.splash: (_) => const SplashPage(),
        AppRoutes.login: (_) => const TelaLogin(),
        AppRoutes.signup: (_) => const SignupPage(),
        AppRoutes.home: (_) => const MainShell(),
        AppRoutes.notifications: (_) => const NotificationsPage(),
        AppRoutes.profile: (_) => const ProfilePage(),
      };
}