import 'package:app_pinho_express/models/user.dart';
import 'package:app_pinho_express/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              height: 70,
              width: double.infinity,
              child: Image.asset(
                'assets/images/sigra-express-logo.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          
          ListTile(
            leading: const Icon(Icons.flight_takeoff_outlined),
            title: const Text('Pedidos',style: TextStyle(fontFamily: 'Poppins')),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.ORDER_ROUTE,
              );
            },
          ),
          const Divider(
            height:0
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Rastreio', style: TextStyle(fontFamily: 'Poppins')),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.TRACKING_ROUTE,
              );
            },
          ),
          const Divider(
            height:0
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Painel de Controle',style: TextStyle(fontFamily: 'Poppins')),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.CONTROL_PANEL_ROUTE,
              );
            },
          ),
          const Divider(height: 0),
          // ListTile(
          //   leading: const Icon(Icons.qr_code),
          //   title: const Text('QRCode',
          //       style: TextStyle(fontFamily: 'Poppins')),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed(
          //       AppRoutes.QRCODE_EXAMPLE_ROUTE,
          //     );
          //   },
          // ),
          // const Divider(
          //   height:0
          // ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout', style: TextStyle(fontFamily: 'Poppins')),
            onTap: () {
              Provider.of<User>(context, listen:false).logout();
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.AUTH_OR_CONTROL_PANEL_ROUTE,
              );
            },
          ),
        ],
      ),
    );
  }
}
