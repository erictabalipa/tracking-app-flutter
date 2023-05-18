import 'package:app_pinho_express/models/user.dart';
import 'package:app_pinho_express/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/notifications_screen.dart';
    
class AppTopNavigation extends StatefulWidget implements PreferredSizeWidget {
  const AppTopNavigation({Key? key, required this.title}) : super(key:key);
  final String title;

  @override
  State<AppTopNavigation> createState() => _AppTopNavigationState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppTopNavigationState extends State<AppTopNavigation> {

  void _navigateNotifications(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return const NotificationsScreen(title: 'Notificacoes');
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title, style: const TextStyle(fontFamily: 'Poppins')),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: IconButton(
            icon: const Icon(
              Icons.notifications_active_outlined
            ),
            onPressed: () => _navigateNotifications(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:15, vertical:5),
          child: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<User>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.AUTH_OR_CONTROL_PANEL_ROUTE,
              );
            },
          ),
        ),
      ],
    );
  }
}