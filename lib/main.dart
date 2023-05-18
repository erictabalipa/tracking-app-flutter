import 'package:app_pinho_express/models/user.dart';
import 'package:app_pinho_express/screens/notifications_screen.dart';
import 'package:app_pinho_express/screens/orders_screen.dart';
import 'package:app_pinho_express/screens/qrcode_tracking_screen.dart';
import 'package:app_pinho_express/screens/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_pinho_express/screens/auth_or_control_panel_screen.dart';
import 'package:app_pinho_express/screens/control_panel.dart';
import 'package:app_pinho_express/utils/app_routes.dart';


void main() {
  runApp(const PinhoExpressApp());
}

class PinhoExpressApp extends StatelessWidget {
  const PinhoExpressApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => User(),
        )
      ],
      child: MaterialApp(
        title: 'Sigraweb Express',
        theme: ThemeData(primarySwatch: Colors.blue),
         
        routes: {
          AppRoutes.AUTH_OR_CONTROL_PANEL_ROUTE: (ctx) => const AuthOrControlPanelScreen(),
          AppRoutes.ORDER_ROUTE: (ctx) => const OrdersScreen(),
          AppRoutes.TRACKING_ROUTE: (ctx) => const TrackingScreen(),
          AppRoutes.CONTROL_PANEL_ROUTE: (ctx) => const ControlPanelScreen(),
          AppRoutes.NOTIFICATION_ROUTE: (ctx) => const NotificationsScreen(
            title: 'NOTIFICACOES',
          ),
        },
        onGenerateRoute: (settings) {
          final uri = Uri.parse(settings.name!);
          if (uri.path == '/express/rastreio/qrcode') {
            final queryParam = uri.queryParameters['trackingCode'];
            return MaterialPageRoute(
              builder: (ctx) => QrCodeTrackingPage(trackingCode: queryParam),
            );
          }
          return null;
        },
        debugShowCheckedModeBanner: false,
      )
    );
  }
}
