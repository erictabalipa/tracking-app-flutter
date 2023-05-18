import 'package:flutter/material.dart';
import '../components/app_top_navigation.dart';
import '../components/app_drawer.dart';

class ControlPanelScreen extends StatefulWidget {
  const ControlPanelScreen({Key? key}) : super(key: key);

  @override
  State<ControlPanelScreen> createState() => _ControlPanelScreenState();
}

class _ControlPanelScreenState extends State<ControlPanelScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppTopNavigation(title: 'PAINEL DE CONTROLE'),
      body: Padding(
        padding: EdgeInsets.all(65),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Center(
              child: Text('DASHBOARD B.I',style: TextStyle(fontFamily: 'Poppins'))
            ),
          ),
        ),
      ),
      drawer: AppDrawer()
    );
  }
}
