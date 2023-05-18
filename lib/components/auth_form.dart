import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exceptions/auth_exception.dart';
import '../models/user.dart';

enum AuthMode { login, recoveryPassword }

// ignore: must_be_immutable
class AuthForm extends StatefulWidget {
  AuthForm({Key? key}) : super(key: key);
  File? image;
  
  @override

  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _emailSended = false;
  bool _rememberMe = false;
  AuthMode _authMode = AuthMode.login;

  final Map<String, String> _authData = {
    'email': '',
    'senha': '',
    'remember-me': '',
  };

  bool _isLogin() => _authMode == AuthMode.login;
  bool _isRecoveryPassword() => _authMode == AuthMode.recoveryPassword;

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() => _authMode = AuthMode.recoveryPassword);
    } else {
      setState(() => _authMode = AuthMode.login);
    }
  }

  Future<void> _showErrorDialog(String msg) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                _emailSended
                ? Icons.sentiment_very_satisfied 
                : Icons.sentiment_very_dissatisfied_outlined
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(_emailSended ? 'Tudo certo!' : 'Ops!'),
              ),
            ]),
          ]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _emailSended ? 'Concluído!' : msg,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                    _emailSended 
                    ? msg 
                    : 'Por favor, revise seus dados de acesso e tente novamente!'
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      }
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    User auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        // Login
        await auth.login(
          _authData['email']!,
          _authData['senha']!,
          _authData['remember-me']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.key);
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  Future<void> _submitRecoveryEmail() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    User auth = Provider.of(context, listen: false);

    try {
      if (_isRecoveryPassword()) {
        // Recovery Password
        await auth.recoveryPassword(
          _authData['email']!,
        );
      }
      setState(() => _emailSended = true);
      _showErrorDialog(
        'Um link foi enviado para seu email com instruções de recuperação!');
    } on AuthException catch (error) {
      _showErrorDialog(error.key);
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          height: _isLogin() ? 360 : 270,
          width: deviceSize.width * 0.8,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:10),
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/sigra-express-logo.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Informe seu e-mail ou usuário',
                    labelText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (mail) {
                    final email = mail ?? '';
                    if (email.trim().isEmpty || !email.contains('@')) {
                      return 'Informe um e-mail válido.';
                    }
                    return null;
                  },
                ),
                if (_isLogin())
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Insira sua senha',
                      labelText: 'Senha',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    controller: _senhaController,
                    onSaved: (senha) => _authData['senha'] = senha ?? '',
                    validator: (pass) {
                      final senha = pass ?? '';
                      if (senha.isEmpty || senha.length < 5) {
                        return 'Informe uma senha válida';
                      }
                      return null;
                    },
                  ),
                if (_isLogin())
                  Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      SizedBox(
                        width:20,
                        height:30,
                        child: Checkbox(
                          side: const BorderSide(
                            width: 1.5,
                            color: Color.fromARGB(255, 125, 125, 125)
                          ),
                          checkColor: Colors.white,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          ),
                          value: _rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                            _authData['remember-me'] = _rememberMe.toString();
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'LEMBRE-SE DE MIM',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color.fromARGB(255, 125, 125, 125)
                          )
                        ),
                      )
                    ]),
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  width: deviceSize.width * 0.8,
                  child: ElevatedButton(
                    onPressed: _isLogin() ? _submit : _submitRecoveryEmail,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      ),
                    ),
                    child: 
                    _isLoading 
                    ? const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      ) 
                    : Text(
                      _isLogin() ? 'ENTRAR' : 'REDEFINIR SENHA',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                      _isLogin() ? 'ESQUECEU SUA SENHA?' : 'JÁ POSSUI SENHA?',
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
