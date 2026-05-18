import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/viewmodel/login_viewmodel.dart';
import '../features/auth/viewmodel/signup_viewmodel.dart';
import '../features/inventory/viewmodel/inventory_viewmodel.dart';
import '../features/chat/viewmodel/chat_viewmodel.dart';
import '../features/home/viewmodel/home_viewmodel.dart';
import '../features/notifications/viewmodel/notifications_viewmodel.dart';
import '../features/sales/viewmodel/sales_viewmodel.dart';

import 'routes/app_pages.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignupViewModel()),
        ChangeNotifierProvider(create: (_) => InventoryViewModel()),
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationsViewModel()),
        ChangeNotifierProvider(create: (_) => SalesViewModel()),
      ],
      child: MaterialApp(
        title: 'Gestão de Sublimação',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}