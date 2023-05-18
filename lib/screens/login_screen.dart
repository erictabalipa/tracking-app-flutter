import 'package:app_pinho_express/components/auth_form.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: deviceSize.height,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
              // SizedBox(
              //   height: deviceSize.height * 0.3,
              //   width: double.infinity,
              //   child: Image.asset(
              //     'assets/images/login-background.jpeg',
              //     fit: BoxFit.fitWidth,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/grupo-pinho-logo.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
            ]),
          ), 
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: deviceSize.height * 0.14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AuthForm(),
              ],
            ),
          ),
        ],
      ), 
    );
  }
}