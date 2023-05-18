class AuthException implements Exception {
  static const Map<String, String> error = {
    'Credenciais incorretas':'Credenciais inválidas',
  };

  final String key;

  AuthException(this.key);

}
