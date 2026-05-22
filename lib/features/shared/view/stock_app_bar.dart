import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../features/notifications/viewmodel/notifications_viewmodel.dart';
import '../../../../app/routes/app_routes.dart';

// COMPONENTE CUSTOMIZADO PARA REUTILIZAÇÃO DA APPBAR
class StockAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StockAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final notifVm = context.watch<NotificationsViewModel>();

    return AppBar(
      backgroundColor: const Color(0xFF09080D),
      elevation: 0,
      title: Text(
        'StockFinance',
        style: GoogleFonts.aoboshiOne(
          color: const Color(0xFFBB4FCF),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.notifications),
            ),
            if (notifVm.naoLidas > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF2D1B4E),
              child: Icon(Icons.person, color: Color(0xFF7A6A9A), size: 18),
            ),
          ),
        ),
      ],
    );
  }
}