import 'package:flutter/material.dart';
import '../../features/auth/view/login_page.dart';
import '../../features/auth/view/splash_page.dart';
import '../../features/auth/view/signup_page.dart';
import '../../features/shared/view/main_shell.dart';
import '../../features/notifications/view/notifications_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String notifications = '/notifications';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashPage(),
        login: (_) => const TelaLogin(),
        signup: (_) => const SignupPage(),
        home: (_) => const MainShell(),
        notifications: (_) => const NotificationsPage(),
      };
}