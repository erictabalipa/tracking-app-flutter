// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/store.dart';
import '../exceptions/auth_exception.dart';

class User with ChangeNotifier {
  String? _token;
  int? _userId;
  String? _nome;
  String? _cpf;
  String? _rg;
  String? _email;
  bool _administrador = false;
  String? _rememberMe;
  String? _expireTokenTime;
  Timer? _logoutTimer;

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  int? get userId {
    return isAuth ? _userId : null;
  }

  String? get nome {
    return isAuth ? _nome : null;
  }

  String? get cpf {
    return isAuth ? _cpf : null;
  }

  String? get rg {
    return isAuth ? _rg : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  bool get isAdministrator {
    return _administrador == true;
  }

  String? get rememberMe {
    return isAuth ? _rememberMe : null;
  }

  Future<void> _authenticate(
      String email, String senha, String rememberMe) async {
    Map<String, String> queryParameters = {
      'email': email,
      'senha': senha,
      'remember-me': rememberMe,
    };

    http.Response response = await http
        .post(Uri.https('lb-api.brazilsouth.cloudapp.azure.com', '/login', queryParameters));

    if (response.headers['error'] != null) {
      final String? errorMessage = response.headers['error'];
      throw AuthException(errorMessage ?? '');
    } else {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      _token = response.headers['x-authtoken'];
      _expireTokenTime = response.headers['access-control-max-age'];
      if (isAuth) {
        _userId = responseBody['id'];
        _nome = responseBody['nome'];
        _cpf = responseBody['cpf'];
        _rg = responseBody['rg'];
        _email = responseBody['email'];
        _administrador = responseBody['administrador'];
      }

      Store.saveMap('userData', {
        'token': _token,
        'userId': _userId,
        'nome': _nome,
        'cpf': _cpf,
        'rg': _rg,
        'email': _email,
        'isAdmin': _administrador
      });

      notifyListeners();
    }
  }

  Future<void> _sendPasswordRecoveryEmail(String email) async {
    final body = {'email': email};
    final jsonString = json.encode(body);
    final uri = Uri.http('lb-api.brazilsouth.cloudapp.azure.com', '/conta/recuperacao-senha');
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.post(uri, headers: headers, body: jsonString);

    if (response.statusCode == 500) {
      final String? recoveryErrorMessage = jsonDecode((response.body));
      throw AuthException(recoveryErrorMessage ?? '');
    }
  }

  Future<void> login(String email, String senha, String rememberMe) async {
    return _authenticate(email, senha, rememberMe);
  }

  Future<void> recoveryPassword(String email) async {
    return _sendPasswordRecoveryEmail(email);
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;
    final userData = await Store.getMap('userData');
    if (userData.isEmpty) return;

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _nome = userData['nome'];
    _cpf = userData['cpf'];
    _rg = userData['rg'];
    _administrador = userData['isAdmin'];

    notifyListeners();
  }

  void logout() async {
    _email = null;
    _token = null;
    final removeUserData = await Store.remove('userData');
    if (!removeUserData) return;
    notifyListeners();
  }

}
