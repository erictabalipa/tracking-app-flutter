import 'package:app_pinho_express/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'login_screen.dart';

class AuthOrControlPanelScreen extends StatelessWidget {
  const AuthOrControlPanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User auth = Provider.of(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const LoginScreen();
        } else {
          return auth.isAuth ? const OrdersScreen() : const LoginScreen();
        }
      })
    );
  }
}
