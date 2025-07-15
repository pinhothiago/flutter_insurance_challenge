class ServerException implements Exception {
  final String message;

  ServerException({this.message = 'Erro no servidor'});
}

class CacheException implements Exception {
  final String message;

  CacheException({this.message = 'Erro no cache local'});
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = 'Sem conexão com a internet'});
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class AuthCanceledException extends AuthException {
  AuthCanceledException() : super('Login cancelado pelo usuário');
}

class AuthFailedException extends AuthException {
  AuthFailedException() : super('Falha na autenticação com Google');
}
